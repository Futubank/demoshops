var amiMenu = {
    
    menuObjects: new Object(),
    
    getElementPosition: function(oElement, oMenu){
        var res = new Array(0, 0);
        // Detect absolute or relative parent offset
        pStopObj = null;
        pObj = oMenu.parentNode;
        while(pObj != null && typeof(pObj.style) != "undefined"){
            if(pObj.style.position == "absolute" || pObj.style.position == "relative"){
                pStopObj = pObj;
                break;
            }
            pObj = pObj.parentNode;
        }
        // Get coordinates
        do{
            if(pStopObj == oElement)
                break;
            res[0] += oElement.offsetLeft;
            res[1] += oElement.offsetTop;
        }while((oElement = oElement.offsetParent) != null);
        return res;
    },

    positioningMenu: function(smNum, relateToParentX, relateToParentY, deltaX, deltaY){
        
        var doReposition = false;
        
        var menuId = "sub_menu_" + smNum;
        var menuObj = amiCommon.getElementById(menuId);
        var parentId = "j" + smNum;
        var parentObj = amiCommon.getElementById(parentId);
        
        var parentPosition = this.getElementPosition(parentObj, menuObj);

        // Reposition menu object so we can get the menu width
        menuObj.style.left = '-2000px';
        menuObj.style.display = 'block';
        var menuWidth = menuObj.offsetWidth;
        var menuHeight = menuObj.offsetHeight;
        menuObj.style.display = 'none';
        
        var clientLeft = amiCommon.getClientLeftPosition();
        var clientRight = amiCommon.getClientRightPosition();
        
        
        
        if(relateToParentX == "right" && menuWidth + parentPosition[0] + deltaX > clientRight){
            relateToParentX = "left";
            deltaX = -deltaX-menuWidth;
        }
        
        if(relateToParentX == "left" || relateToParentY == "top"){
            doReposition = true;
        }
        
        if(typeof(deltaX) == "undefined")
            deltaX = 0;
        if(relateToParentX == "right" || relateToParentX == "center"){
            parentWidth = parentObj.offsetWidth;
            if(relateToParentX == "center")
                parentWidth = parentWidth/2;
            deltaX += parentWidth;
        }
        
        if(typeof(deltaY) == "undefined")
            deltaY = 0;
        if(relateToParentY == "bottom" || relateToParentY == "center"){
            parentHeight = parentObj.offsetHeight;
            if(relateToParentY == "center")
                parentHeight = parentHeight/2;
            deltaY += parentHeight;
        }
        
        menuObj.style.position = 'absolute';
        menuObj.style.left = parentPosition[0] + deltaX+'px';
        menuObj.style.top = parentPosition[1] + deltaY+'px';
        
        this.menuObjects[smNum] = {
            'left' : menuObj.style.left,
            'top' : menuObj.style.top,
            'width' : menuWidth,
            'height' : menuHeight
        };
        
        return doReposition;
    },
    
    repositionMenu: function(smNum){
        if(typeof(this.menuObjects[smNum]) != 'undefined'){
            var menuObj = amiCommon.getElementById('sub_menu_'+smNum);
            if(menuObj.offsetWidth != this.menuObjects[smNum]['width']){
                menuObj.style.left = parseInt(menuObj.style.left) + this.menuObjects[smNum]['width'] - menuObj.offsetWidth + 'px';
            }
        }
    },

    hTmMenuShow: null,
    hTmMenuHide: null,
    hTmSubMenuHide: {"init":0},
    prevImgSrc: Array(),
    openedMenusStack: Array(),

    showMenu: function(waitTime, smNum, parentNum, relateToParentX, relateToParentY, deltaX, deltaY){
        var doReposition = false;
        
        if(this.hTmMenuShow != null){
            clearTimeout(this.hTmMenuShow);
        }
        if(waitTime > 0){
            this.hTmMenuShow = setTimeout('amiMenu.showMenu(0, '+smNum+', '+parentNum+', "'+relateToParentX+'", "'+relateToParentY+'", '+deltaX+', '+deltaY+')', waitTime);
        }else{
            var menuObj = amiCommon.getElementById("sub_menu_" + smNum);
            if(menuObj != null){
                clearTimeout(this.hTmMenuHide);
                clearTimeout(this.hTmSubMenuHide[smNum]);
                
                this.hideMenuById(parentNum, true, true);
                var doReposition = this.positioningMenu(smNum, relateToParentX, relateToParentY, deltaX, deltaY);
              
                amiCommon.getElementById("sub_menu_" + smNum).style.display = 'block';
                this.openedMenusStack.push(smNum);
            }
        }
        
        return doReposition;
    },

    showMenuFromUrl: function(waitTime, contentURL, isLoadOnce, smNum, parentNum, relateToParentX, relateToParentY, deltaX, deltaY){
        if(this.hTmMenuShow != null){
            clearTimeout(this.hTmMenuShow);
        }
        if(waitTime > 0){
            this.hTmMenuShow = setTimeout('amiMenu.showMenuFromUrl(0, "'+contentURL+'", '+isLoadOnce+', '+smNum+', '+parentNum+', "'+relateToParentX+'", "'+relateToParentY+'", '+deltaX+', '+deltaY+')', waitTime);
        }else{
            var testElement = amiCommon.getElementById('sub_menu_'+smNum);
            var doLoadContent = false;
            if(testElement != null && !isLoadOnce){
                testElement.innerHTML = 'Загрузка...';
                doLoadContent = true;
            }
            if(testElement == null){
                menuDiv = document.createElement('div');
                menuDiv.id = 'sub_menu_'+smNum;
                menuDiv.className = 'amiSubmenu';
                menuDiv.innerHTML = 'Загрузка...';
                menuDiv.onmouseover = function(){amiMenu.mon(smNum, parentNum)};
                menuDiv.onmouseout = function(){amiMenu.moff(smNum, parentNum)};
                testElement = document.body.appendChild(menuDiv);
                if(testElement != null){
                    doLoadContent = true;
                }
            }
            var doReposition = this.showMenu(0, smNum, parentNum, relateToParentX, relateToParentY, deltaX, deltaY);
            if(doLoadContent){
                if(doReposition){
                    amiAjax.setElementContentFromUrl('sub_menu_'+smNum, 'GET', contentURL, 'action=getmenu&menuid='+smNum, 'menu', smNum);
                }else{
                    amiAjax.setElementContentFromUrl('sub_menu_'+smNum, 'GET', contentURL, 'action=getmenu&menuid='+smNum);
                }
            };
        }
    },

    hideMenu: function(smNum){
        var menuObj = amiCommon.getElementById("sub_menu_" + smNum);
        if(menuObj != null){
            menuObj.style.display = 'none';
        }
    },

    hideMenuById: function(smNum, isIdParent, hideAllIfNotFound){
        if(smNum == 0){
            this.hideMenuAll();
        }else{
            var removeFromPos = -1;
            for(i = 0; i < this.openedMenusStack.length; i++){
                if(this.openedMenusStack[i] == 0)
                    break;
                if(removeFromPos == -1 && this.openedMenusStack[i] == smNum){
                    removeFromPos = i;
                    if(isIdParent){
                        removeFromPos += 1;
                        continue;
                    }
                }
                if(removeFromPos > -1){
                    this.hideMenu(this.openedMenusStack[i]);
                }
            }
            if(hideAllIfNotFound && removeFromPos == -1){
                this.hideMenuAll();
            }else if(removeFromPos > -1 && removeFromPos < this.openedMenusStack.length){
                this.openedMenusStack.splice(removeFromPos, this.openedMenusStack.length-removeFromPos);
            }
        }
    },

    hideMenuAll: function(){
        for(i = this.openedMenusStack.length-1; i >= 0; i--){
            this.hideMenu(this.openedMenusStack[i]);
        }
        this.openedMenusStack = new Array();
    },

    hideMenuAllByTimeout: function(){
        this.hTmMenuHide = setTimeout('amiMenu.hideMenuAll()', 500);
    },
    
    hideMenuIdByTimeout: function(smNum){
        this.hTmSubMenuHide[smNum] = setTimeout('amiMenu.hideMenuById('+smNum+', false, false)', 250);
    },

    /* HTML handlers */
    mon: function(smNum, smParentId){
        clearTimeout(this.hTmMenuHide);
        if(typeof(smNum) != "undefined" && smNum > 0){
            clearTimeout(this.hTmSubMenuHide[smNum]);
        }
        if(typeof(smParentId) != "undefined" && smParentId > 0){
            clearTimeout(this.hTmSubMenuHide[smParentId]);
        }
    },
    
    moff: function(smNum, evt){
        this.hideMenuAllByTimeout();
        if(typeof(smNum) != "undefined"){
            this.hideMenuIdByTimeout(smNum);
        }
        if(typeof(evt) != "undefined"){
            if(typeof(evt.cancelBubble) != "undefined"){
                evt.cancelBubble = true;
                if(typeof(evt.stopPropagation) == "function")
                    evt.stopPropagation();
            }
        }
    },
    
    submoff: function(menuId){
        if(this.hTmMenuShow != null){
            clearTimeout(this.hTmMenuShow);
        }
        this.hideMenuIdByTimeout(menuId);
    },
    
    ck: function (num,state){
    },
    
    smclick: function(){
        this.hideMenuAll();
    }
}