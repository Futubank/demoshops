<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiCatalog_Items 
 * @version    $Id$ 
 * @size       19664 xkqwlnulnnznspustrrsqrurxymklpppzwiztwnmiqkmlnzsxtinupwntninkkxnxumypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiCatalog/Items configuration front action controller.
 *
 * @package    Config_AmiCatalog_Items
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_Items_Frn extends Hyper_AmiMultifeeds_Frn{
}

/**
 * AmiCatalog/Items configuration Skin mode list component controller.
 *
 * @package    Config_AmiCatalog_Items
 * @subpackage Controller
 * @resource   {$modId}/list/controller/frn <code>AMI::getResource('{$modId}/list/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_Items_ListFrn extends Hyper_AmiMultifeeds_ListFrn{
}

/**
 * AmiCatalog/Items configuration Skin mode list component view.
 *
 * @package    Config_AmiCatalog_Items
 * @subpackage View
 * @resource   {$modId}/list/view/frn <code>AMI::getResource('{$modId}/list/view/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_Items_ListViewFrn extends Hyper_AmiMultifeeds_ListViewFrn{
}

/**
 * AmiCatalog/Items configuration Skin mode form component controller.
 *
 * @package    Config_AmiCatalog_Items
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_Items_FormFrn extends Hyper_AmiMultifeeds_FormFrn{
    /**
     * Save action dispatcher.
     *
     * @param  array &$aEvent  Event data
     * @return void
     */
    protected function _save(array &$aEvent){

        // collect special flags {

        $oRequest = AMI::getSingleton('env/request');
        $section = AMI_ModDeclarator::getInstance()->getSection($this->getModId());
        $flags = 0; // $oRequest->get('flags', $flags);
        $extraSpecFlagsNumber = AMI::getOption($section . '_home', 'num_extra_special_flags');
        for($i = 0; $i <= $extraSpecFlagsNumber; ++$i){
            if($oRequest->get('special_flag_' . $i, FALSE)){
                $flags = $flags | (1 << $i);
            }else{
                $flags = $flags & ~(1 << $i);
            }
        }
        $oRequest->set('flags', $flags);

        // } collect special flags

        parent::_save($aEvent);
    }
}

/**
 * AmiCatalog/Items configuration Skin mode form component view.
 *
 * @package    Config_AmiCatalog_Items
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @amidev     temporary
 */
class AmiCatalog_Items_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators = array();

    /**
     * Module section.
     *
     * @var string
     */
    protected $section;

    /**
     * Extra prices data to modify angular model
     *
     * @var array
     * @see AmiCatalog_Items_FormViewFrn::init()
     */
    protected $aExtraPrices = array();

    /**
     * Extra price rates to base currency.
     *
     * @var array
     */
    protected $aExtraPriceRates = array();

    /**
     * Price format.
     *
     * @var array
     */
    protected $aPriceFormat;

    /**
     * Prepares templates paths and blockname.
     *
     * @return void
     * @amidev
     */
    protected function prepareTemplates(){
        parent::prepareTemplates();

        $oTpl = $this->getTemplate();
        $modId = $this->getModId();
        $this->section = AMI_ModDeclarator::getInstance()->getSection($modId);
        $oTpl->mergeBlock(
            $this->tplBlockName,
            dirname($this->tplFileName) . '/' . $modId . '_form.tpl');
        $this->aLocale =
            $oTpl->parseLocale(dirname($this->localeFileName) . '/' . $modId . '_form.lng') +
            $oTpl->parseLocale(AMI_iTemplate::LOCAL_LNG_PATH . '/' . $this->section . '_home.lng') +
            $this->aLocale;
    }

    /**
     * Initialization.
     *
     * @return AMI_View
     */
    public function init(){
        unset($this->aCommonFieldsValidators['announce']);

        parent::init();

        $oRequest = AMI::getSingleton('env/request');

        // form {

        $oEshop = AMI::getSingleton('eshop');
        $this->aPriceFormat = array(
            'decimalPoint'       => $oEshop->getDecimalPoint(),
            'numberOfDecimals'   => $oEshop->getNumberDecimals(),
            'thousandsSeparator' => $oEshop->getThousandsSeparator()
        );

        $this->addField(
            array(
                'name'    => 'scripts',
                'caption' => ''
            ) + $this->aPriceFormat
        );

        // override type 'datetime' of field
        $this->addField(
            array(
                'name'     => 'date_created',
                'type'     => 'date',
                'validate' => array('date')
            )
        );

        $this->addField(
            array(
                'name' => 'flags',
                'type' => 'hidden'
            )
        );

        $this->addField(
            array(
                'name'     => 'price',
                'position' => 'header.after',
                'validate' => array('price'),
                'marker'   => 'number'
            )
        );

        $this->addTab(
            'special_announce_tab',
            'default_tabset',
            self::TAB_STATE_COMMON,
            'announce_tab.after'
        );
        $this->addField(
            array(
                'name'     => 'special_announce',
                'type'     => 'htmleditor',
                'position' => 'special_announce_tab.end'
            )
        );

        // extra prices, discount {

        $this->addTab(
            'extra_prices_tab',
            'default_tabset',
            self::TAB_STATE_COMMON,
            'body_tab.after'
        );

        $baseCurrency = $oEshop->getBaseCurrency();
        $aCurrencies = $oEshop->getCurrencies();
        $aExtraPrices = $oEshop->getOtherPrices();
        $aExtraPriceCurrencies = array();
        $id = (int)$oRequest->get('id', 0);
        if(sizeof($aExtraPrices)){
            $catId = 0;
            if($id){
                $oItem =
                    AMI::getResourceModel($this->getModId() . '/table')
                    ->find(
                        $id,
                        array_merge(
                            array('id', 'id_cat', 'price', 'price_mask'),
                            array_map(
                                array($this, 'cbPrependPrice'),
                                $aExtraPrices
                            )
                        )
                    );
                if($oItem->getId()){
                    $catId = (int)$oItem->id_cat;
                }else{
                    $id = 0;
                    unset($oItem);
                }
            }

            $priceMask = $oRequest->get('price_mask', FALSE);
            if(FALSE === $priceMask && isset($oItem)){
                $priceMask = $oItem->price_mask;
            }

            $oCatTable =
                AMI::getResourceModel($this->section . '_cat/table');
            if($catId){
                $oCatItem = $oCatTable->find($catId);
            }
            if(!$catId || !$oCatItem->getId()){
                // load main category for current locale
                $oCatItem =
                    $oCatTable
                    ->findByFields(
                        array(
                            'id_parent' => 0,
                            'lang'      => AMI_Registry::get('lang_data')
                        )
                    );
                $catId = (int)$oCatItem->getId();
                if(!$catId){
                    trigger_error(
                        "Main category for locale '" .
                        AMI_Registry::get('lang_data') .
                        "' not found",
                        E_USER_ERROR
                    );
                }
            }
            unset($oCatTable);
            $aRates = array(
                $baseCurrency => 1
            );
            foreach($aCurrencies as $currency => $aCurrency){
                if($baseCurrency != $currency && $aCurrency['exchange']){
                    $aRates[$currency] = (double)$aCurrency['exchange'];
                }
            }
            $this->aExtraPriceRates = array();

            $this->addField(
                array(
                    'name'               => 'extra_price_opener',
                    'position'           => 'extra_prices_tab.end',
                    'element_caption'    => '',
                    'usedExtraPrices'    => json_encode($aExtraPrices),
                    'rates'              => json_encode($aRates),
                    'baseCurrency'       => $baseCurrency
                ) + $this->aPriceFormat
            );
            foreach($aExtraPrices as $priceId){
                $price = 'price' . $priceId;
                $aField =
                    array(
                        'name'                => $price,
                        'marker'              => 'extra_price',
                        'element_caption'     => '',
                        'extra_price_caption' => $oCatItem->{'price_caption' . $priceId},
                        'price_id'            => $priceId
                    );
                $aCatPriceData = array(
                    'formula' => '',
                    'display' => '',
                    'store'   => ''
                );
                $aPriceData = $oCatItem->$price ? explode('#', $oCatItem->$price) : NULL;
                if($aPriceData){
                    $aCatPriceData['formula'] = $aPriceData[0];
                    $aCurrencies = explode(':', $aPriceData[1]);
                    if(sizeof($aCurrencies)){
                        $aCatPriceData['display'] = $aCurrencies[0];
                        $aCatPriceData['store'] = $aCurrencies[0];
                        $aExtraPriceCurrencies[$priceId] = $aCatPriceData['store'];
                        if(isset($aCurrencies[1])){
                            $aCatPriceData['store'] = $aCurrencies[1];
                            $aExtraPriceCurrencies[$priceId] = $aCatPriceData['store'];
                        }
                    }
                    unset($aCurrencies);
                }
                $aField['currency'] = $aCatPriceData['store'];
                $this->aExtraPriceRates[$priceId] =
                    isset($aRates[$aField['currency']]) ? $aRates[$aField['currency']] : 1;

                if('' != $aCatPriceData['formula']){
                    $aField['formula'] = $aCatPriceData['formula'];
                    // $aField['price_disabled'] = ' disabled="yes"';
                    // $aField['use_formula_checked'] = ' checked="yes"';
                    $this->aExtraPrices['formula' . $priceId] = $aField['formula'];
                    if(isset($oItem)){
                        if((1 << ($priceId - 1)) & $priceMask){
                            $this->aExtraPrices['use_formula' . $priceId] = 1;
                        }
                    }else{
                        $this->aExtraPrices['use_formula' . $priceId] = 1;
                    }
                }else{
                    $aField['use_formula_disabled'] = ' disabled="yes"';
                }
                $this->addField(
                    array(
                        'name'    => 'use_formula' . $priceId,
                        'type'    => 'checkbox',
                        'marker'  => 'none',
                        'caption' => ''
                    )
                );
                $this->addField($aField);
            }
        }
        if(sizeof($this->aExtraPrices)){
            if(isset($oItem)){
                $this->addField(array(
                    'name'  => 'price_mask',
                    'type'  => 'hidden',
                    'value' => $priceMask
                ));
            }
            $this->addField(
                array(
                    'name'                 => 'extra_price_closer',
                    'position'             => 'extra_prices_tab.end',
                    'element_caption'      => '',
                    'extraPriceCurrencies' => json_encode($aExtraPriceCurrencies)
                )
            );
            // Fill model with extra price fields
            AMI_Event::addHandler(
                'on_form_fields_form',
                array($this, 'handleFormFields'),
                $this->getModId()
            );
        }

        $aCurrencies = $oEshop->getCurrencies();
        // Discount
        $aData = array(
            array(
                'name'     => $aCurrencies[$baseCurrency]['name'],
                'value'    => 'abs',
                'selected' => !$id
            ),
            array(
                'name'  => '%',
                'value' => 'percent'
            )
        );
        $this->addField(
            array(
                'name'     => 'discount',
                'type'     => 'select',
                'data'     => $aData,
                'position' => 'extra_prices_tab.end'
            )
        );
        $aField =
            array(
                'name' => 'discount_type'
            );
        if(!$id){
            $aField['value'] = 'abs';
        }
        $this->addField($aField);

        // } extra prices, discount

        $this->addField(
            array(
                'name'     => 'max_quantity',
                'position' => 'date_created.after',
            )
        );

        $this->addField(
            array(
                'name'     => 'id_external',
                'position' => 'details_noindex.after'
            )
        );

        $this->addField(
            array(
                'name'     => 'max_quantity',
                'position' => 'date_created.after',
                'marker'   => 'number'
            )
        );

        $this->addField(
            array(
                'name'     => 'max_quantity',
                'marker'   => 'number'
            )
        );

        $this->addField(
            array(
                'name'     => 'weight',
                'marker'   => 'number'
            )
        );

        $this->addField(
            array(
                'name'     => 'size',
                'marker'   => 'number'
            )
        );

        $this->addField(
            array(
                'name'     => 'rest',
                'marker'   => 'number'
            )
        );

        // special flags {

        $this->addSection('special_flags', 'rest.after');
        $extraSpecFlagsNumber = AMI::getOption($this->section . '_home', 'num_extra_special_flags');
        for($i = 0; $i <= $extraSpecFlagsNumber; ++$i){
            $this->addField(
                array(
                    'name'            => 'special_flag_' . $i,
                    'type'            => 'checkbox',
                    'position'        => 'special_flags.end',
                    'element_caption' => $this->aLocale['special_flag_' . $i]
                )
            );
        }

        // } special flags
        // } form

        return $this;
    }

    /**
     * Setting up model item object.
     *
     * @param  AMI_iFormModTableItem $oItem  Item model
     * @return AMI_ModFormView
     */
    public function setModelItem(AMI_iFormModTableItem $oItem){
        parent::setModelItem($oItem);

        if($oItem->getId() && isset($oItem->flags)){
            $extraSpecFlagsNumber = AMI::getOption($this->section . '_home', 'num_extra_special_flags');
            for($i = 0; $i <= $extraSpecFlagsNumber; ++$i){
                $oItem->setValue('special_flag_' . $i, (int)(bool)((1 << $i) & $oItem->flags));
            }
        }

        return $this;
    }

    /**
     * Fill model with extra price fields.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     * @see    AMI_ModFormView::get()
     */
    public function handleFormFields($name, array $aEvent, $handlerModId, $srcModId){
        $oItem = $aEvent['oItem'];

        $oItem->setValues($this->aExtraPrices);

        foreach($this->aExtraPriceRates as $priceId => $rate){
            $field = $this->cbPrependPrice($priceId);
            if(isset($oItem->$field)){
                if(1 != $rate){
                    $oItem->$field = $oItem->$field * $rate;
                }

                $oItem->$field = number_format(
                    $oItem->$field,
                    $this->aPriceFormat['numberOfDecimals'],
                    $this->aPriceFormat['decimalPoint'],
                    $this->aPriceFormat['thousandsSeparator']
                );
            }
        }
        $oItem->price = number_format(
            $oItem->price,
            $this->aPriceFormat['numberOfDecimals'],
            $this->aPriceFormat['decimalPoint'],
            $this->aPriceFormat['thousandsSeparator']
        );

        return $aEvent;
    }

    /**
     * Converts extra price number to db field.
     *
     * @param  int $value  Price number
     * @return string
     */
    protected function cbPrependPrice($value){
        return 'price' . $value;
    }

    /**
     * Return form data parsed to fields and validators data.
     * @return array
     * @amidev Temporary
     */
    protected function getFieldsData(){
        $aValidators = (is_object($this->oItem)) ? $this->oItem->getValidators() : array();
        $aFields = array();
        foreach($this->aFields as $field => $aField){
            $aFieldScope = $this->getFieldScope($aField);
            $value = isset($aFieldScope['value']) ? $aFieldScope['value'] : '';
            switch($aField['type']){
                case 'checkbox':
                    $value = !empty($aFieldScope['checked']) ? 1 : 0;
                    break;
                case 'date':
                case 'datetime':
                    if(!$value){
                        $value = date('Y-m-d H:i:s');
                    }else{
                        $parts = explode(' ', $value);
                        if(count($parts) == 1){
                            $value .= ' 00:00:00';
                        }
                    }
                    break;
                default:
                    break;
            }
            $aFields[$field] = array(
                'type' => $aField['type'],
                'value' => $value
            );
            if($field == 'id_page'){
                if(!$aFields[$field]['value']){
                    $aFields[$field]['value'] = 0;
                }
            }
            if($field == 'mod_id'){
                $aFields[$field]['value'] = $this->getModId();
            }
            if($field == 'mod_action'){
                $aFields[$field]['value'] = 'form_save';
            }
        }
        return array(
            'aFields'       => $aFields,
            'aValidators'   => $aValidators
        );
    }
}
