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
        AMI.CatalogFilter.transformSelect('parent_id_category');
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
        AMI.CatalogFilter._onPageContentReceived(oMod);
        return true;
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
                    ? '<a href="#" onclick="return AMI.CatalogFilter.selectCategory(' + aResult[i].id + ');">' + aResult[i].caption + '</a> | '
                    : aResult[i].caption + ' | ';
            }
        }
        html += '<b>' + oCatField.options[selectedIndex].getAttribute('data-ami-caption') + '</b>';

        oPathDiv.innerHTML = html;
    },

    selectCategory: function(catId){
        this.oForm.elements['category'].value = catId;
        this.oItemForm.elements['cat_id'].value = catId;
        this.oItemForm.elements['enc_cat_id'].value = catId;
        AMI.Page.addHashData(
            this.modId,
            {
                category: catId,
                cat_id: catId
            }
        );
        this.processFilter = false;
        var oInput = document.createElement('INPUT');
        oInput.type = 'hidden';
        oInput.name = 'enc_force_cat_id';
        oInput.value = catId;
        oInput.setAttribute('enc_type', 'encoded');
        $('#_async_marker').before(oInput);
        var oInput = document.createElement('INPUT');
        oInput.type = 'hidden';
        oInput.name = 'force_cat_id';
        oInput.value = catId;
        $('#_async_marker').before(oInput);
        user_click('rsrtme', '');
        return false;
    },

    _onPageContentReceived: function(oMod){
        if(this.oComponent == null){
            // Initialization on first load
            this.oComponent = oMod.getComponentsByType('form_filter')[0];
            this.modId = this.oComponent.oModule.moduleId;
            this.oForm = this.oComponent.oForm;
            this.oItemForm = document.forms[_cms_document_form];
        }
        this.catId = this.oForm.elements['category'].value;
        this.displayPath();
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
    },
}

AMI.CatalogFilter.init();
"-->
