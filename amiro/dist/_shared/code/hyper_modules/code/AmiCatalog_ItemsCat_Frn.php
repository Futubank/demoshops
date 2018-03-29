<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiCatalog_ItemsCat 
 * @version    $Id$ 
 * @size       10503 xkqwrulmtrnntrwxrszmqmspugnzmwqwrnkprilggirtzuqlxszqzwimynulipzxlnzppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiCatalog/Categories configuration front action controller.
 *
 * @package    Config_AmiCatalog_ItemsCat
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_ItemsCat_Frn extends Hyper_AmiMultifeeds_Frn{
}

/**
 * AmiCatalog/Categories configuration Skin mode list component controller.
 *
 * @package    Config_AmiCatalog_ItemsCat
 * @subpackage Controller
 * @resource   {$modId}/list/controller/frn <code>AMI::getResource('{$modId}/list/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_ItemsCat_ListFrn extends Hyper_AmiMultifeeds_ListFrn{
}

/**
 * AmiCatalog/Categories configuration Skin mode list component view.
 *
 * @package    Config_AmiCatalog_ItemsCat
 * @subpackage View
 * @resource   {$modId}/list/view/frn <code>AMI::getResource('{$modId}/list/view/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_ItemsCat_ListViewFrn extends Hyper_AmiMultifeeds_CatListViewFrn{

    /**
     * Order column
     *
     * @var string
     */
    protected $orderColumn = 'date_modified';

    /**
     * Initialization.
     */
    public function init(){
        parent::init();
        $this->removeColumn('date_created');
    }
}

/**
 * AmiCatalog/Categories configuration Skin mode form component controller.
 *
 * @package    Config_AmiCatalog_ItemsCat
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_ItemsCat_FormFrn extends Hyper_AmiMultifeeds_FormFrn{
}

/**
 * AmiCatalog/Categories configuration Skin mode form component view.
 *
 * @package    Config_AmiCatalog_ItemsCat
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_ItemsCat_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
    /**
     * Eshop object
     *
     * @var AMI_Eshop
     */
    protected $oEshop;

    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators = array();

    /**
     * Initialization.
     */
    public function init(){
        
        $this->oEshop = AMI::getSingleton('eshop');

        parent::init();

        $this->addTab('extra_prices_tab', 'default_tabset', self::TAB_STATE_COMMON, 'body_tab.after');

        $aPrices = AMI::getOption('eshop_item', 'extrafield_price_on');

        // Add currencies
        $aCurrencies = $this->oEshop->getCurrencies();
        $baseCurrency = $this->oEshop->getBaseCurrency();
        $aRates = array(
            $baseCurrency => 1
        );
        foreach($aCurrencies as $currency => $aCurrency){
            if($baseCurrency != $currency && $aCurrency['exchange']){
                $aRates[$currency] = (double)$aCurrency['exchange'];
            }
        }

        $this->addScriptCode('var baseCurrency = "' . $baseCurrency . '";');
        $this->addScriptCode('var aCurrencies = {};');
        foreach($aRates as $currency => $rate){
            $this->addScriptCode('aCurrencies["' . $currency . '"] = ' . $rate . ';');
        }

        // Add list of prices names
        foreach($aPrices as $price){
            $caption = str_replace('price', 'price_caption', $price);
            $this->addField(array('name' => $caption, 'position' => 'extra_prices_tab.end'));
        }

        $this->addField(array('name' => 'price', 'marker' => 'number', 'position' => 'extra_prices_tab.end'));

        if(count($aPrices)){
            $this->addSection('extra_prices', 'extra_prices_tab.end');

            // Add prices
            foreach($aPrices as $price){
                $this->addField(array('name' => $price, 'marker' => 'extra_price', 'position' => 'extra_prices.end'));
            }

            // Add checkboxes
            $this->addField(array('name' => 'update_all', 'type' => 'checkbox', 'position' => 'extra_prices_tab.end'));
            $this->addField(array('name' => 'update_force', 'type' => 'checkbox', 'position' => 'extra_prices_tab.end'));
        }
        
        // Add discount
        $aDiscounts = array(
            array(
                'name' => '---',
                'value' => 0
            )
        );
        AMI_Registry::set('AMI/models/eshop_discounts/nojoin/eshop_cat', TRUE);
        $oDiscountList = AMI::getResourceModel('eshop_discounts/table')->getList();
        $oDiscountList->addSearchCondition(array('public' => 1, 'condition' => 'category'))->addColumns(array('header', 'type', 'amount', 'id'))->load();
        foreach($oDiscountList as $oDiscount){
            $aDiscounts[] = array(
                'name' => $this->_getDiscountHeader($oDiscount),
                'value' => $oDiscount->getId()
            );
        }
        $this->addField(array('name' => 'id_discount', 'type' => 'select', 'data' => $aDiscounts, 'position' => 'extra_prices_tab.end'));
        $this->addField(array('name' => 'discount_apply_to_subcategories', 'type' => 'checkbox', 'position' => 'extra_prices_tab.end'));

        $this->addField(
            array(
                'name'     => 'id_external',
                'position' => 'details_noindex.after'
            )
        );
    }

    /**
     * Setting up model item object.
     *
     * @param  AMI_iFormModTableItem $oItem  Item model
     * @return AMI_ModFormView
     */
    public function setModelItem(AMI_iFormModTableItem $oItem){
        parent::setModelItem($oItem);

        $oCat = new AmiExt_EshopCategory('eshop_item');
        $parentCatId = AMI::getSingleton('env/request')->get('category_id', 0);
        if(!$oItem->getId()){
            $oItem->id_parent = $parentCatId;
        }
        $aCatList = $oCat->getCatList(TRUE);
        $branchDeletionStarted = FALSE;
        $lastLevel = 0;
        foreach($aCatList as $idx => $aCat){
            if($aCat['id'] == $oItem->getId()){
                unset($aCatList[$idx]);
                $branchDeletionStarted = TRUE;
                $lastLevel = $aCat['level'];
                continue;
            }
            if($branchDeletionStarted){
                if($aCat['level'] > $lastLevel){
                    unset($aCatList[$idx]);
                    continue;
                }else{
                    $branchDeletionStarted = FALSE;
                }
            }
            if(!$oItem->getId() && ($aCat['id'] == $parentCatId)){
                $aCatList[$idx]['selected'] = TRUE;
            }
            if($oItem->getId() && ($aCat['id'] == $oItem->parent_id)){
                $aCatList[$idx]['selected'] = TRUE;
            }
        }
        $aSelectField = array(
            'name'  => 'id_parent',
            'type'  => 'select',
            'data'  => $aCatList,
            'value' => $oItem->id_parent,
            'position' => 'header.after',
            'validate' => array('filled')
        );
        /*
        if(!$oItem->id_parent){
            $aSelectField['not_selected'] = array(
                'id'      => '',
                'caption' => 'select_category'
            );
        }*/

        $this->addField($aSelectField);

        return $this;
    }

    /**
     * Returns formatted discount name.
     * 
     * @param AmiDiscount_Discount_TableItem $oDiscount  Discount item
     * @return string
     * @amidev
     */
    protected function _getDiscountHeader($oDiscount)
    {
        $header = $oDiscount->header;
        $header .= " (" . (
            $oDiscount->amount == 0
            ? $this->aLocale["combined"]
            : $oDiscount->amount . " " . (
                $oDiscount->type == "abs"
                ? $this->oEshop->getCurrencyString($oDiscount->amount, $this->oEshop->getBaseCurrency())
                : "%")) . ")";

        return $header;
    }

    /**
     * Prepares templates paths and blockname.
     *
     * @return void
     * @amidev
     */
    protected function prepareTemplates(){
        parent::prepareTemplates();

        $oTpl = $this->getTemplate();
        $oTpl->mergeBlock($this->tplBlockName, AMI_Skin::getPath('templates/eshop_cat_form.tpl'));
        $this->aLocale =
            $oTpl->parseLocale(AMI_Skin::getPath('templates/lang/eshop_cat_form.lng')) + $this->aLocale;

        for($i=1; $i<=16; $i++){
            $this->aLocale['form_field_price_caption' . $i] = $this->aLocale['price_caption'] . ' ' . $i;
            $this->aLocale['form_field_price' . $i] = $this->aLocale['price_value'] . ' ' . $i . ' [price' . $i . ']';
        }
    }
     /**
      * Return form data parsed to fields and validators data.
      * @return array
      * @amidev Temporary
      */
    protected function getFieldsData(){
        $baseCurrency = $this->oEshop->getBaseCurrency();
        $aData = parent::getFieldsData();
        $aPrices = AMI::getOption('eshop_item', 'extrafield_price_on');
        foreach($aPrices as $price){
            $priceValue = $aData['aFields'][$price]['value'];
            $aPriceParts = explode('#', $priceValue);
            $formula = $aPriceParts[0];
            $dbCurr = "";
            $siteCurr = $baseCurrency;
            if(isset($aPriceParts[1])){
                $aOtherParts = explode(':', $aPriceParts[1]);
                $siteCurr = $aOtherParts[0];
                if(isset($aOtherParts[1])){
                    $dbCurr = $aOtherParts[1];
                }
            }
            $aData['aFields'][$price . '_formula'] = array(
                'type' => 'hidden',
                'value' => $aPriceParts[0]
            );
            $aData['aFields'][$price . '_currency_db'] = array(
                'type' => 'hidden',
                'value' => $dbCurr
            );
            $aData['aFields'][$price . '_currency_site'] = array(
                'type' => 'hidden',
                'value' => $siteCurr
            );
        }
        return $aData;
    }

}
