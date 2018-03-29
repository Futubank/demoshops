AMI.UI.DnD = {
    initialMouseX: undefined,
    initialMouseY: undefined,
    startX: undefined,
    startY: undefined,
    draggedObject: undefined,
    movedObjects: {},

    initElement: function (windowEl, draggableEl) {
        AMI.UI.DnD.movedObjects[draggableEl.id] = windowEl.id;
        draggableEl.onmousedown = AMI.UI.DnD.startDragMouse;
    },

    startDragMouse: function (e) {
        AMI.UI.DnD.startDrag(this);
        var evt = e || window.event;
        AMI.UI.DnD.initialMouseX = evt.clientX;
        AMI.UI.DnD.initialMouseY = evt.clientY;
        AMI.Browser.Event.addHandler(document,'mousemove',AMI.UI.DnD.dragMouse);
        AMI.Browser.Event.addHandler(document,'mouseup',AMI.UI.DnD.releaseElement);
        AMI.Browser.Event.addHandler(AMI.UI.DnD.draggedObject,'click',AMI.UI.DnD.removeClass);
        return false;
    },

    startDrag: function (obj) {
        if(AMI.UI.DnD.draggedObject){
            AMI.UI.DnD.releaseElement();
        }
        var dragArea = AMI.find('#' + AMI.UI.DnD.movedObjects[obj.id]);

        if(AMI.Browser.isIE || AMI.Browser.isOpera){
            AMI.UI.DnD.startX = typeof(dragArea.style.left) != 'undefined' ? parseInt(dragArea.style.left) : 0;
            AMI.UI.DnD.startY = typeof(dragArea.style.top) != 'undefined' ? parseInt(dragArea.style.top) : 0;
        }else{
            AMI.UI.DnD.startX = dragArea.offsetLeft;
            AMI.UI.DnD.startY = dragArea.offsetTop;
        }
        AMI.UI.DnD.draggedObject = obj;
        AMI.addClass(obj, 'dragged');
    },

    dragMouse: function (e) {
        var evt = e || window.event;
        var dX = evt.clientX - AMI.UI.DnD.initialMouseX;
        var dY = evt.clientY - AMI.UI.DnD.initialMouseY;
        AMI.UI.DnD.setPosition(dX,dY);
        return false;
    },

    setPosition: function (dx,dy) {
        dragArea = AMI.find('#' + AMI.UI.DnD.movedObjects[AMI.UI.DnD.draggedObject.id]);
        dragArea.style.left = parseInt(parseInt(AMI.UI.DnD.startX) + dx) + 'px';
        dragArea.style.top = parseInt(parseInt(AMI.UI.DnD.startY) + dy) + 'px';
    },

    releaseElement: function() {
        AMI.Browser.Event.removeHandler(document,'mousemove',AMI.UI.DnD.dragMouse);
        AMI.Browser.Event.removeHandler(document,'mouseup',AMI.UI.DnD.releaseElement);
        AMI.removeClass(AMI.UI.DnD.draggedObject, 'dragged');
    },

    removeClass: function(e){
        if(typeof(e.target) != 'undefined'){
            var el = e.target;
            if((typeof(el.tagName) != 'undefined') && (el.tagName == 'A')){
                return;
            }
        }
        AMI.Browser.Event.stopProcessing(e);
        AMI.UI.DnD.draggedObject = null;
    }
}
