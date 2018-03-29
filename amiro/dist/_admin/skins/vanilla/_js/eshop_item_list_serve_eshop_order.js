AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oArgs){
        if(oArgs.oComponent.componentId == '##_component_id##'){
            switch(action){
                case 'list_add_to_order':
                    var oList = oArgs.oComponent.getListData().data.list;
                    for(var i = 0, q = oList.length; i < q; i++){
                        if(oList[i].id == oArgs.oParameters.id){
                            if(oList[i].data.hasProps){
                                alert(AMI.Template.Locale.get('products_having_props_adding_forbidden'));
                                return false;
                            }

                            // get path to the picture
                            if(typeof(oList[i].picture) != 'undefined'){
                                var imgSrc = AMI.$('.componentList TR[data-ami-row-id="' + oArgs.oParameters.id + '"] div.list-image img').attr('src');
                                if(typeof(imgSrc) != 'undefined' && imgSrc != ''){
                                    var picture = imgSrc;
                                    var pictureBig = oList[i].picture_big;
                                }else{
                                    var picture, pictureBig = '';
                                }
                            }else{
                                var picture, pictureBig = '';
                            }

                            var
                                priceNumber = AMI.find('###_component_id##_price_selector_' + oList[i].id).value,
                                oData = {
                                    id:         oArgs.oParameters.id,
                                    sku:        oList[i].sku,
                                    header:     oList[i].header,
                                    price:      {number: priceNumber, value: oList[i].prices[priceNumber]},
                                    tax:        oList[i].data.tax,
                                    discount:   oList[i].data.discount,
                                    shipping:   oList[i].data.shipping,
                                    picture:    picture,
                                    pictureBig: pictureBig
                                };
                            break;
                        }
                    }
                    if(typeof(oData) == 'object' && typeof(top.addOrderItem) == 'function'){
                        top.addOrderItem(oData);
                        top.popupWindow.closeAll();
                    }
                    return false;
                case 'positionIsFirst':
                case 'list_move_up':
                case 'list_move_down':
                case 'list_move_top':
                case 'list_move_bottom':
                case 'list_public':
                case 'list_unpublic':
                    return false;
            }
        }
        return true;
    }
);
