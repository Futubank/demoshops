var AmiOrderEditor = {

    // Round precision
    roundPrec: 2,

    // Order items
    orderItems: [],

    /**
     * Attach order editor to the form
     */
    attach: function(){
        this.collectItemsData();
        this.applyOnchange();
        this.calcTotals();
        AMI.$('#order_shipping').change(function(){
            AmiOrderEditor.calcTotals();
        });
        AMI.Message.addListener('ON_ORDER_EDIT_ADD_ITEM', this.addItemHandler);
        AMI.Message.addListener('ON_ORDER_EDIT_DELETE_ITEM', this.deleteItemHandler);
        AMI.Message.addListener('ON_FORM_SUBMIT', this.formSubmitHandler);
    },

    formSubmitHandler: function(action, aParams){
        var itemCount = 0;
        for(var i=0; i<AmiOrderEditor.orderItems.length; i++){
            if(AmiOrderEditor.orderItems[i].qty > 0){
                itemCount++;
            }else{
                if((typeof(AmiOrderEditor.orderItems[i].deleted) == 'undefined') || !AmiOrderEditor.orderItems[i].deleted){
                    var oItemRow = AmiOrderEditor.getRowByIndex(AmiOrderEditor.orderItems[i].index);
                    var oInput = oItemRow.children('td:eq(2)').find('INPUT');
                    invalidQty(oInput);
                    return false;
                }
            }
        }
        if(!itemCount){
            if(typeof(window.emptyOrderDenied) == 'function'){
                window.emptyOrderDenied();
            }
        }
        return (itemCount > 0);
    },

    collectItemsData: function(oRow){
        if(typeof(oRow) == 'undefined'){
             var aRows = AMI.$('TR.productsEditTableRow');
             for(var i=0; i<aRows.length; i++){
                 AmiOrderEditor.collectItemsData(AMI.$(aRows[i]));
             }
        }else{
            var aItem = {};

            // General data
            aItem.orderItemId   = oRow.children('td:eq(0)').find('INPUT:eq(0)').val();
            aItem.id            = oRow.children('td:eq(0)').find('INPUT:eq(1)').val();
            aItem.name          = oRow.children('td:eq(1)').find('INPUT:eq(0)').val();
            aItem.sku           = oRow.children('td:eq(1)').find('INPUT:eq(1)').val();
            aItem.qty           = oRow.children('td:eq(2)').find('INPUT').val();

            // Discounts
            aItem.prcDiscount   = oRow.children('td:eq(3)').find('INPUT:eq(0)').val();
            aItem.absDiscount   = oRow.children('td:eq(3)').find('INPUT:eq(1)').val();

            // Taxes
            aItem.taxValue      = AmiOrderEditor.validateFloat(oRow.children('td:eq(4)').find('INPUT:eq(0)').val());
            aItem.taxType       = oRow.children('td:eq(4)').find('SELECT:eq(0)').val();
            aItem.taxChargeType = oRow.children('td:eq(4)').find('SELECT:eq(1)').val();
            aItem.taxItem       = oRow.children('td:eq(4)').find('INPUT:eq(1)').val();
            aItem.taxTotal      = oRow.children('td:eq(4)').find('INPUT:eq(2)').val();

            // Prices
            aItem.originalPrice = oRow.children('td:eq(5)').find('INPUT:eq(0)').val();
            aItem.price         = oRow.children('td:eq(5)').find('INPUT:eq(1)').val();
            aItem.currentPrice  = oRow.children('td:eq(5)').find('INPUT:eq(2)').val();
            aItem.taxPrice      = oRow.children('td:eq(5)').find('INPUT:eq(3)').val();
            aItem.orderPrice    = oRow.children('td:eq(5)').find('INPUT:eq(4)').val();
            aItem.priceNumber   = oRow.children('td:eq(5)').find('INPUT:eq(5)').val();

            if(oRow.attr('data-ami-item') == null){
                var counter = AmiOrderEditor.orderItems.length;
                oRow.attr('data-ami-item', counter);
                aItem.index = counter;
                AmiOrderEditor.orderItems.push(aItem);
            }else{
                AmiOrderEditor.orderItems[AmiOrderEditor.getRowItemIndex(oRow)] = aItem;
            }
        }
    },

    applyOnchange: function(oRow){
        if(typeof(oRow) == 'undefined'){
             var aRows = AMI.$('TR.productsEditTableRow');
             for(var i=0; i<aRows.length; i++){
                 AmiOrderEditor.applyOnchange(AMI.$(aRows[i]));
             }
        }else{
            // And add onchange recalculation for each changeble input element
            oRow.find('input,select').each(function(){
                var oInput = AMI.$(this);
                if(!oInput.attr('readonly')){
                    oInput.change(function(elm){
                        return function(){
                            AmiOrderEditor.calcRow(elm.parents('TR.productsEditTableRow:eq(0)'), elm);
                        }
                    }(oInput));
                }
            });
            // And add onchange recalculation for each changeble input element
            oRow.find('input').each(function(){
                var oInput = AMI.$(this);
                if(!oInput.attr('readonly')){
                    oInput.blur(function(elm){
                        return function(){
                            elm.val(AmiOrderEditor.validateFloat(elm.val()));
                        }
                    }(oInput));
                }
            });
        }
    },

    /**
     * Add item action handler
     */
    addItemHandler: function(action, aParams){
        if(action == 'select'){
            var bShowImage = parseInt(AMI.$('#show_image_in_order_details').text());
            var currencyCode = AMI.$('#order_base_currency').val();
            openExtDialog(
                '',
                'engine.php?mod_id=eshop_item&serve=eshop_order&mode=popup&order_currency=' + currencyCode + '&show_image_in_order_details=' + bShowImage,
                true,
                true
            );
        }
        if(action == 'insert'){
            var aItem = aParams.item;
            AmiOrderEditor.insertItemRow(aItem);
        }
    },

    /**
     * Get a copy of first list row
     */
    insertItemRow: function(aItem){
        var oRow = AMI.$('TR.productsEditTableRow')[0];
        var counter = AMI.$('TR.productsEditTableRow').length;
        var oNewRow = AMI.$(oRow.cloneNode(true));

        // Clear images if any
        oNewRow.find('div.image_order_details').html('');

        oNewRow.css('display', '');

        // Update input element's indexes
        oNewRow.find('[name$="\\[0\\]"]').each(function(cntr){
            return function(index){
                this.name = this.name.replace('[0]', '[' + cntr + ']');
            }
        }(counter));

        oNewRow.attr('data-ami-item', counter);

        // Adds onchange handlers for all input elements
        AmiOrderEditor.applyOnchange(oNewRow);

        // Fill with data
        var newRow = true;
        for(var i=0; i<this.orderItems.length; i++ ){
            var aOrderItem = this.orderItems[i];
            if((aOrderItem.id == aItem.id) && (aOrderItem.priceNumber == aItem.price.number)){
                this.orderItems[i].qty++;
                var oItemRow = this.getRowByIndex(aOrderItem.index);
                if(this.orderItems[i].deleted){
                    this.orderItems[i].deleted = 0;
                    oItemRow.css('display', '');
                }
                AmiOrderEditor.fillItemRow(oItemRow, aOrderItem);
                newRow = false;
            }
        }
        if(newRow){
            AmiOrderEditor.fillItemRow(oNewRow, AmiOrderEditor.addItem(aItem));
            AMI.$(oRow.parentNode).append(oNewRow);
        }

        AmiOrderEditor.calcTotals();
    },

    /**
     * Adds a new item with data from a popup
     */
    addItem: function(aItem){
        aItem.orderItemId = 0;
        aItem.originalPrice = aItem.price.value;
        aItem.priceNumber = aItem.price.number;
        aItem.qty = 1;
        aItem.name = aItem.header;
        aItem.index = AmiOrderEditor.orderItems.length;

        if(aItem.discount.type == 'abs'){
            aItem.absDiscount = aItem.discount.value;
            aItem = AmiOrderEditor.calcItemDiscounts(aItem, 'prc');
        }else{
            aItem.prcDiscount = aItem.discount.value;
            aItem = AmiOrderEditor.calcItemDiscounts(aItem, 'abs');
        }

        // todo: shipping in aItem.shipping {type: abs/percent, value: xxx}

        aItem.taxType = aItem.tax.type;
        aItem.taxValue = aItem.tax.value;
        aItem.taxChargeType = aItem.tax.charge;

        aItem = AmiOrderEditor.calcItemTaxes(aItem);
        aItem = AmiOrderEditor.calcItemPrices(aItem);

        AmiOrderEditor.orderItems.push(aItem);

        return aItem;
    },

    /**
     * Fill item row with item data
     */
    fillItemRow: function(oRow, aItem){
        var bShowImage = parseInt(AMI.$('#show_image_in_order_details').text());

        oRow.children('td:eq(0)').find('SPAN').html(aItem.id);
        oRow.children('td:eq(0)').find('INPUT:eq(0)').val(aItem.orderItemId);
        oRow.children('td:eq(0)').find('INPUT:eq(1)').val(aItem.id);

        // add image if it exists
        if(typeof(aItem.picture) != 'undefined'
            && aItem.picture != ''
            && bShowImage
        ){
            oRow.children('td:eq(1)').find('DIV:eq(1)').html('');
            // make picture
            var imgNode = document.createElement('img');
            imgNode.src = aItem.picture;
            imgNode.style.max_width = '200px;';

            // make link
            var imgLink = document.createElement('a');
            imgLink.href = "javascript:;";
            imgLink.setAttribute(
                'onclick',
                "new AMI.UI.Popup('<img src=\"" + aItem.pictureBig + "\" style=\"max-width:400px;\">', {id: 'imgPopup', width: 420, autoshow: true, modal: false, header: '" + aItem.name +"'});"
            );
            imgLink.appendChild(imgNode);

            // add picture to the product
            oRow.children('td:eq(1)').find('DIV:eq(1)').append(imgLink);
        }

        oRow.children('td:eq(1)').find('SPAN:eq(0)').html(aItem.name);
        oRow.children('td:eq(1)').find('INPUT:eq(0)').val(aItem.name);
        oRow.children('td:eq(1)').find('SPAN:eq(1)').html(aItem.sku);
        oRow.children('td:eq(1)').find('INPUT:eq(1)').val(aItem.sku);
        oRow.children('td:eq(2)').find('INPUT').val(aItem.qty);
        oRow.children('td:eq(3)').find('INPUT:eq(0)').val(aItem.prcDiscount);
        oRow.children('td:eq(3)').find('INPUT:eq(1)').val(aItem.absDiscount);
        oRow.children('td:eq(4)').find('INPUT:eq(0)').val(AmiOrderEditor.validateFloat(aItem.taxValue));
        oRow.children('td:eq(4)').find('INPUT:eq(1)').val(AmiOrderEditor.validateFloat(aItem.taxItem));
        oRow.children('td:eq(4)').find('INPUT:eq(2)').val(AmiOrderEditor.validateFloat(aItem.taxTotal));
        oRow.children('td:eq(5)').find('INPUT:eq(0)').val(aItem.originalPrice);
        oRow.children('td:eq(5)').find('INPUT:eq(1)').val(aItem.price);
        oRow.children('td:eq(5)').find('INPUT:eq(2)').val(aItem.currentPrice);
        oRow.children('td:eq(5)').find('INPUT:eq(3)').val(aItem.taxPrice);
        oRow.children('td:eq(5)').find('INPUT:eq(4)').val(aItem.orderPrice);
        // oRow.addClass('just-added');
    },

    /**
     * Delete item action handler
     */
    deleteItemHandler: function(action, aParams){
        var oRow = AMI.$(aParams.target.parentNode.parentNode);
        oRow.children('td:eq(2)').find('INPUT').val(0);
        var index = AmiOrderEditor.getRowItemIndex(oRow);
        AmiOrderEditor.orderItems[index].qty = 0;
        AmiOrderEditor.orderItems[index].deleted = 1;
        oRow.css('display', 'none');
        AmiOrderEditor.calcTotals();
    },

    /**
     * Returns item index for specified table row
     */
    getRowItemIndex: function(oRow){
        return oRow.attr('data-ami-item');
    },

    /**
     * Returns row object by item index
     */
    getRowByIndex: function(index){
        return AMI.$('TR.productsEditTableRow[data-ami-item=' + index + ']');
    },

    /**
     * Perform a row recalculation
     */
    calcRow: function(oRow, oCaller){
        AmiOrderEditor.collectItemsData(oRow);
        var index = AmiOrderEditor.getRowItemIndex(oRow);
        var aItem = AmiOrderEditor.orderItems[index];

        // Quantity changed
        if(oCaller.attr('name').indexOf('items_qty') == 0){
            aItem = AmiOrderEditor.calcItemDiscounts(aItem, 'abs');
        }

        // Absolute discount changed
        if(oCaller.attr('name').indexOf('items_abs_discount') == 0){
            aItem = AmiOrderEditor.calcItemDiscounts(aItem, 'prc');
        }

        // Precentage discount changed
        if(oCaller.attr('name').indexOf('items_prc_discount') == 0){
            aItem = AmiOrderEditor.calcItemDiscounts(aItem, 'abs');
        }

        aItem = AmiOrderEditor.calcItemTaxes(aItem);
        aItem = AmiOrderEditor.calcItemPrices(aItem);

        AmiOrderEditor.calcTotals();

        AmiOrderEditor.fillItemRow(oRow, aItem);
        AmiOrderEditor.orderItems[index] = aItem;
    },

    /**
     * Calculate taxes for the item
     */
    calcItemTaxes: function(aItem){
        var price = this.getPriceWithDiscount(aItem);
        switch(aItem.taxChargeType){
            case 'detach':
                aItem.taxItem = AmiOrderEditor.getDetachTax(price, aItem.taxValue, aItem.taxType);
                break;
            case 'charge':
                aItem.taxItem = AmiOrderEditor.getChargeTax(price, aItem.taxValue, aItem.taxType);
                break;
        }
        aItem.taxTotal = aItem.taxItem * aItem.qty;
        return aItem;
    },

    getChargeTax: function(price, taxVal, taxType){
        var res = 0;
        switch(taxType){
            case "abs":
                res = taxVal;
                break;
            case "percent":
                res = price / 100 * taxVal;
                break;
            default:
                break;
        }
        res = this.round(res);
        return res;
    },

    getDetachTax: function(price, taxVal, taxType){
        var res = 0;
        switch(taxType){
            case "abs":
                res = taxVal;
                break;
            case "percent":
                res = (price * taxVal) / (100 + taxVal);
                break;
            default:
                break;
        }
        res = this.round(res);
        return res;
    },

    /**
     * Calculate discounts for the item
     */
    calcItemDiscounts: function(aItem, force){
        if(typeof(force) == 'undefined'){
            if((typeof(aItem.prcDiscount) == 'undefined')||(aItem.prcDiscount == '')){
                force = 'prc';
            }
            if((typeof(aItem.absDiscount) == 'undefined')||(aItem.absDiscount == '')){
                force = 'abs';
            }
        }
        if(force == 'prc'){
            aItem.prcDiscount = AmiOrderEditor.round((aItem.absDiscount / (aItem.originalPrice * aItem.qty)) * 100);
            force = 'abs';
        }
        if(force == 'abs'){
            aItem.absDiscount = AmiOrderEditor.round(aItem.originalPrice * aItem.qty * aItem.prcDiscount / 100);
        }
        return aItem;
    },

    /**
     * Calculate prices for the item
     */
    calcItemPrices: function(aItem){
        var dPrice = this.getPriceWithDiscount(aItem);

        aItem.currentPrice = this.round(dPrice, 6);
        aItem.price = this.round(aItem.currentPrice);
        aItem.taxPrice = dPrice;
        aItem.orderPrice = aItem.taxPrice;

        if(aItem.taxItem){
            switch(aItem.taxChargeType){
                case "charge":
                    aItem.currentPrice = this.round(dPrice, 6);
                    aItem.price = this.round(aItem.currentPrice);
                    var taxVal = this.validateFloat(aItem.taxItem);
                    aItem.taxPrice = aItem.currentPrice + taxVal;
                    aItem.orderPrice = aItem.taxPrice;
                    break;
                case "detach":
                    aItem.taxPrice = dPrice;
                    aItem.orderPrice = aItem.taxPrice;
                    var taxVal = this.validateFloat(aItem.taxItem);
                    aItem.currentPrice = this.round(aItem.currentPrice - taxVal, 6);
                    aItem.price = this.round(aItem.currentPrice);
                    break;
                default:
                    break;
            }
        }

        return aItem;
    },

    calcTotals: function(){
        var orderSubtotal = 0;
        var orderTotal = 0;
        var taxTotal = 0;
        var orderShipping = this.validateFloat(AMI.$('#order_shipping').val());
        for(var i=0; i<AmiOrderEditor.orderItems.length; i++){
            var oItem = AmiOrderEditor.orderItems[i];
            if(!oItem.deleted){
                orderSubtotal += oItem.price * oItem.qty;
                taxTotal += parseFloat(oItem.taxTotal);
                orderTotal += oItem.orderPrice * oItem.qty;
            }
        }
        orderTotal += orderShipping;
        AMI.$('#order_subtotal').val(this.validateFloat(orderSubtotal));
        AMI.$('#order_total').val(this.validateFloat(orderTotal));
        AMI.$('#tax_total').val(this.validateFloat(taxTotal));
    },

    getPriceWithDiscount: function(aItem){
        var res = aItem.originalPrice - (aItem.originalPrice / 100 * aItem.prcDiscount);
        res = this.validateFloat(res);
        return res;
    },

    validateFloat: function(val, roundPrecision){
        if(isNaN(val) || val == ""){
            val = 0;
        }
        val = parseFloat(val);
        if(val < 0 ){
            val = 0;
        }

        if(typeof(roundPrecision) == 'undefined'){
            var roundPrecision = this.roundPrec;
        }
        val = this.round(val, roundPrecision);
        return val;
    },

    validateInt: function(val){
        if(isNaN(val) || val == ""){
            val = 0;
        }
        val = parseInt(val);
        if(val < 0 ){
            val = 0;
        }
        return val;
    },

    /**
     * Round a value
     */
    round: function(val, prec){
        if((typeof(prec) == 'undefined') || !prec){
            prec = this.roundPrec;
        }
        var rounder = Math.pow(10, prec);
        val = Math.round(val * rounder) / rounder;
        return val;
    },

    dummy: null
}

/**
 * Initials
 */
AMI.$(document).ready(function(){
    AMI.$('SELECT[name=buy_currency]').change(function(){
        AMI.$('INPUT[name=buy_exchange]').val(AMI.$('SELECT[name=buy_currency]').val());
    });
    AmiOrderEditor.attach();
	AMI.$('#total__caption_goods_value').text(AMI.$('#info-value__caption_goods_value').text());
	AMI.$('#total__price_shipping').text(AMI.$('#info-value__shipping').text());
	AMI.$('#total__title_discount').text(AMI.$('#info-value__applied_discount').text());
	AMI.$('#total__number_items').text(AMI.$('#info-value__order_total_qty').text());
	AMI.$('#total__order_total_weight').text(AMI.$('#info-value__order_total_weight').text());
	AMI.$('#total__total_caption_amount').text(AMI.$('#info-value__amount').text());
});

/**
 * Add new item to the row
 */
function addOrderItem(aItem){
    AMI.Message.send('ON_ORDER_EDIT_ADD_ITEM', 'insert', {item: aItem});
}
