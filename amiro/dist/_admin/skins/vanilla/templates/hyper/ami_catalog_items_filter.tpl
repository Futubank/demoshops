##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_filter.tpl"%%

<!--#set var="select_field_row(name=category)" value="<option value="##value##" ##selected####attributes##>##caption##</option>"-->

<!--#set var="path_all" value=""-->

<!--#set var="javascript" value="

AMI.CatalogFilter = {
    modId:       '',
    oComponent:  null,
    oForm:       null,
    oItemForm:   null,
    catId:       '',
    processFilter: true,

    init: function(){
        AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', this.onPageContentReceived);
        AMI.Message.addListener('ON_MODULE_ACTION',         this.onModuleAction);
        AMI.CatalogFilter.transformSelect('id_category');
    },

    transformSelect: function(selObjectId){
        if(!AMI.$('#' + selObjectId).prop('chosen')){
            AMI.$('#' + selObjectId + ' option').each(function() {
                var option = $(this),
                    search = '',
                    next,
                    prev;

                if ('undefined' === typeof (option.data('search'))) {
                    option.data('search', '');
                }

                next = option.next();
                while (next.length && option.data('amiLevel') < next.data('amiLevel')) {
                    if ( next.data('amiLevel') != option.data('amiLevel') ) {
                        option.data('search', option.data('search') + ' ' + next.text());
                    }
                    next = next.next();
                }
            });

            AMI.$('#' + selObjectId).chosen({
                search_contains: true,
                disable_search_threshold: 20,
                search_in_attr: 'search',
                width: '200px',
                no_results_text: AMI.Template.Locale.get('not_found')
            });

            AMI.$('#' + selObjectId).prop('chosen', true);
        }
    },

    onPageContentReceived: function(oMod){
        return AMI.CatalogFilter._onPageContentReceived(oMod);
    },

    onModuleAction: function(action, oArgs){
        return AMI.CatalogFilter._onModuleAction(action, oArgs);
    },

    displayPath: function(){
        var
            oPathDiv = $('#path_' + this.oComponent.componentId)[0],
            oCatField = this.oForm.elements['category'],
            catId = parseInt(oCatField.value);

        if(isNaN(catId) || catId <= 0){
            oPathDiv.style.display = 'none';
            oPathDiv.innerHTML = '';
            return false;
        }else{
            oPathDiv.style.display = 'block';
        }

        var
            selectedIndex = oCatField.selectedIndex,
            level = parseInt(oCatField.options[selectedIndex].getAttribute('data-ami-level')) + 1,
            captionOffset = oCatField.options[selectedIndex].text.length - oCatField.options[selectedIndex].getAttribute('data-ami-caption').length,
            currentLevel = level, aPath = [], lev,
            catMaxLength = ##cat_max_length##, pathMaxLength = ##path_max_length##, catStartQty = ##cat_start_qty##, catEndQty = ##cat_end_qty##, pathStripText = '##path_strip_text##';

        for(var i = selectedIndex; i >= 0; i--){
            lev = parseInt(oCatField.options[i].getAttribute('data-ami-level'));

            if(lev < currentLevel){
                var tmpCatId = parseInt(oCatField.options[i].value);

                if(isNaN(tmpCatId)){
                    break;
                }
                currentLevel = lev;
                aPath[currentLevel + 1] = ({id: tmpCatId, caption: oCatField.options[i].getAttribute('data-ami-caption')});
            }
        }

        var length = 0, aResult = [];

        for(i = currentLevel + 1; i <= level; i++){
            var oRow = aPath[i];

            oRow.caption = this._strip(oRow.caption, catMaxLength);
            aResult.push(oRow);
            length += oRow.caption.length;
            if(length >= pathMaxLength){
                break;
            }
        }

        if(length < pathMaxLength || (catStartQty + catEndQty) >= aPath.length){
            aResult = aPath;
        }else{
            var aLevels = [];

            for(i in aPath){
                if(!isNaN(parseInt(i))){
                    aLevels.push(parseInt(i));
                }
            }


            for(i = 0; i < catStartQty ; i++){
                aResult[aLevels[i]] = {id: aPath[aLevels[i]].id, caption: this._strip(aPath[aLevels[i]].caption, catMaxLength)};
            }
            aResult[aLevels[catStartQty]] = {id: -1, caption: pathStripText};
            for(i = aPath.length - catEndQty - 1; i < aPath.length - 1; i++){
                aResult[aLevels[i]] = {id: aPath[aLevels[i]].id, caption: this._strip(aPath[aLevels[i]].caption, catMaxLength)};
            }
        }

        // Build path

        aResult[0] = {id: 0, caption: '%%path_all%%'};

        var html = '';

        for(i = 0; i < aResult.length - 1; i++){
            if(typeof(aResult[i]) != 'undefined'){
                html +=
                    aResult[i].id > -1
                    ? '<a href="javascript:void(0);" onclick="return AMI.CatalogFilter.jumpToCategory(' + aResult[i].id + ');">' + aResult[i].caption + '</a> | '
                    : aResult[i].caption + ' | ';
            }
        }

        var oSelect = document.createElement('SELECT');

        oSelect.onchange = function(){
            return AMI.CatalogFilter.jumpToCategory(this.options[this.selectedIndex].value);
        };

        var index = selectedIndex;
        while(index > 0 && (parseInt(oCatField.options[index - 1].getAttribute('data-ami-level')) + 1) == level){
            index--;
        }

        i = 0;
        do{
            if((parseInt(oCatField.options[index].getAttribute('data-ami-level')) + 1) < level){
                break;
            }
            oSelect.options[i] = new Option(
                oCatField.options[index].text.substring(captionOffset),
                oCatField.options[index].value,
                index == selectedIndex,
                index == selectedIndex
            );

            index++;
            if(index >= oCatField.options.length){
                break;
            }
            i++;
        }while(true);

        oPathDiv.innerHTML = html;

        oPathDiv.appendChild(oSelect);
    },

    jumpToCategory: function(catId){
        AMI.$('.flt_form #id_category option[value=' + catId + ']').attr('selected', 'selected');
        AMI.$('.flt_form #id_category').trigger("chosen:updated");
        AMI.Page.addHashData(module_name, {category: catId});
        var filter = AMI.Page.getModule(module_name).getComponentsByType('form_filter')[0];
        AMI.Page.doModuleAction(module_name, filter.componentId, 'filter');
        this.selectCategory(catId);
        return false;
    },

    selectCategory: function(catId, oParameters){
        // Update category
        frm = AMI.$(window.document.eshop_form);
        if(frm.find('INPUT[name="id"]').val() == ''){
            if((typeof(oParameters) == 'undefined') || (typeof(oParameters.reloadForm) == 'undefined') || oParameters.reloadForm){
                window.categoriesTransferred = false;
                AMI.Page.addHashData(module_name, {ami_full:1});
                AMI.Page.addHashData(module_name, {category: catId});
                AMI.Page.addHashData(module_name, {cid: catId});
                var form = AMI.Page.getModule(module_name).getComponentsByType('form')[0];
                AMI.Page.getModule(module_name).openEditForm({ami_full:1, cid: catId}, true);
                AMI.Page.deleteHashData(module_name, 'cid', true);

            }
        }
        return true;
    },

    _onPageContentReceived: function(oMod){
        if(this.oComponent == null){
            // Initialization on first load
            this.oComponent = oMod.getComponentsByType('form_filter')[0];
            this.modId = this.oComponent.oModule.moduleId;
            this.oForm = this.oComponent.oForm;
            if(typeof(_cms_document_form) != 'undefined' && typeof(document.forms[_cms_document_form]) != 'undefined'){
                this.oItemForm = document.forms[_cms_document_form];
            }
            this.catId = this.oForm.elements['category'].value;
        }
        this.displayPath();
        return true;
    },

    _onModuleAction: function(action, oArgs){
        if(this.processFilter){
            switch(action){
                case 'filter':
                    if(this.catId != this.oForm.elements['category'].value){
                        return this.selectCategory(this.oForm.elements['category'].value, oArgs);
                    }
                    break;
                case 'filter_reset':
                    if(parseInt(this.catId) > 0){
                        return this.selectCategory(0, oArgs);
                    }
                    break;
            }
        }
        return true;
    },

    _strip: function(str, len){
        if(str.length > len){
            str = str.substring(0, len - 3).replace(/\s+$/, '') + '...';
        }
        return str;
    }
}

AMI.CatalogFilter.init();
"-->
