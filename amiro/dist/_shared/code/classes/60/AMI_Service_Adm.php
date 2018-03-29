<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4960 xkqwmntwkntkqqxlinsgmimrtqlkgnwyrxtiiymikrwynrsizwpimnysilqzinyzyilmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI admin service class.
 *
 * @package Service
 * @static
 * @since   x.x.x
 * @amidev  Temporary
 */
final class AMI_Service_Adm{
    /**
     * Section (owners) captions
     *
     * @var array
     */
    private static $aSections = array();

    /**
     * Module captions
     *
     * @var array
     */
    private static $aModCaptions = array();

    /**
     * Module captions with it's parnets
     *
     * @var array
     */
    private static $aModCaptionsWithParents = array();

    /**
     * Returns modules captions.
     *
     * @param  array $aModIds           Modules ids
     * @param  bool  $useParentesis     Flag specifying to returna captions as "Paremnt module name : Module name"
     * @param  array $aSections         Sections to prepend before modules
     * @param  bool  $addMainModuleName
     * @param  bool  $prefixBySection
     * @return array
     */
    public static function getModulesCaptions(
        array $aModIds,
        $useParentesis = TRUE,
        array $aSections = array(),
        $addMainModuleName = FALSE,
        $prefixBySection = FALSE
    ){
        if(empty(self::$aSections)){
            self::buildModulesCaptions($addMainModuleName);
        }
        $aCaptions =
            array_intersect_key(
                $useParentesis ? self::$aModCaptionsWithParents : self::$aModCaptions,
                array_flip($aModIds)
            );
        $oDeclarator = AMI_ModDeclarator::getInstance();
        if($prefixBySection && !sizeof($aSections)){
            $aSections = $oDeclarator->getSections();
        }
        if(sizeof($aSections)){
            global $Core;

            $aModIds = array_keys($aCaptions);
            foreach($aModIds as $modId){
                $section = '';
                if($oDeclarator->isRegistered($modId)){
                    $section = $oDeclarator->getSection($modId);
                }elseif('full' == AMI::getEnvMode()){
                    $oMod = $Core->GetModule($modId);
                    if(is_object($oMod) && $oMod->IsInstalled()){
                        $section = $oMod->GetOwnerName();
                    }
                }
                if(in_array($section, $aSections)){
                    $aCaptions[$modId] = self::$aSections[$section] . ' : ' . $aCaptions[$modId];
                }
            }
        }
        asort($aCaptions);

        return $aCaptions;
    }

    /**
     * Fills modules caption arrays.
     *
     * @return void
     */
    private static function buildModulesCaptions($addMainModuleName){
        $oTpl = AMI::getSingleton('env/template_sys');
        self::$aSections = $oTpl->parseLocale('templates/lang/_menu_owners.lng');
        $aLocale = $oTpl->parseLocale('templates/lang/_menu_all.lng');
        $aGroupLocale = array();
        $oDeclarator = AMI_ModDeclarator::getInstance();
        foreach($aLocale as $modId => $caption){
            self::$aModCaptions[$modId] = $caption;
            if($oDeclarator->isRegistered($modId)){
                $section = $oDeclarator->getSection($modId);
                if(!isset($aGroupLocale[$section])){
                    $aGroupLocale[$section] = $oTpl->parseLocale('templates/lang/_menu_' . $section . '.lng');
                }
                $parentModId = $oDeclarator->getParent($modId);
                if(is_null($parentModId)){
                    $groupCaption = isset($aGroupLocale[$section][$modId]) ? $aGroupLocale[$section][$modId] : FALSE;
                    if($groupCaption && ($groupCaption !== $caption)){
                        $caption = !$addMainModuleName ? $groupCaption : $groupCaption . ' : ' . $caption;
                    }
                    //d::vd($modId . ' < ' . $groupCaption);
                }else{
                    $groupCaption = isset($aGroupLocale[$section][$parentModId]) ? $aGroupLocale[$section][$parentModId] : '{ ' . $parentModId . ' }';
                    $parentCaption = isset($aLocale[$parentModId]) ? $aLocale[$parentModId] : '{ ' . $parentModId . ' }';
                    if($groupCaption !== $parentCaption){
                        $parentCaption = $groupCaption;
                    }
                    $caption = $parentCaption . ' : ' . $caption;
                }
            }
            self::$aModCaptionsWithParents[$modId] = $caption;
        }
    }
}
