##-- row renderer description ( --##

<!--#set var="render_row(module=articles);render_row(module=blog);render_row(module=kb_item);render_row(module=news)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img_small != "")@@<img src="@@ext_img_small@@" alt="" />@@endif@@
        @@if(fdate != "")@@<div class="ami_resp_row_fdate_##module##">@@fdate@@</div>@@endif@@
        @@if(cat_header != "")@@<div class="ami_resp_row_cat_header_##module##">@@cat_header@@</div>@@endif@@
        <div class="ami_resp_row_header_##module##"><a href="@@url@@">@@header@@</a></div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>
    <hr>
</div>
"-->

<!--#set var="render_row(module=stickers)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img_small != "")@@<img src="@@ext_img_small@@" alt="" />@@endif@@
        @@if(fdate != "")@@<div class="ami_resp_row_fdate_##module##">@@fdate@@</div>@@endif@@
        @@if(cat_header != "")@@<div class="ami_resp_row_cat_header_##module##">@@cat_header@@</div>@@endif@@
        <div class="ami_resp_row_header_##module##">@@header@@</div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>
    <hr>
</div>
"-->

<!--#set var="render_row(module=files)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img_small != '')@@<img src="@@ext_img_small@@" alt="" />@@endif@@
        @@if(fdate != '')@@<div class="ami_resp_row_fdate_##module##">@@fdate@@</div>@@endif@@
        <div class="ami_resp_row_header_##module##">
            <a href="ftpgetfile.php?id=@@id@@&module=files"><img src="ftpicons/small_@@type@@.gif" alt="" align="middle" border="0" /></a>
            <a href="ftpgetfile.php?id=@@id@@&module=files">@@header@@</a>
        </div>
        <div>%%file_size%%: @@size@@</div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>
    <hr>
</div>
"-->

<!--#set var="render_row(module=photoalbum)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img_small != '')@@<img src="@@ext_img_small@@" alt="" />@@endif@@
        @@if(fdate != '')@@<div class="ami_resp_row_fdate_##module##">@@fdate@@</div>@@endif@@
        @@if(cat_header != '')@@<div class="ami_resp_row_cat_header_##module##">@@cat_header@@ </div>@@endif@@
        <div class="ami_resp_row_header_##module##"><a href="@@url@@">@@header@@</a></div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>
    <hr>
</div>
"-->

<!--#set var="render_row(module=eshop_item)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img != '')@@<img src="@@ext_img@@" alt="" style="width: 150px;" />@@endif@@
        @@if(cat_header != '')@@<div class="ami_resp_row_cat_header_##module##">@@cat_header@@ </div>@@endif@@
        <div class="ami_resp_row_header_##module##"><a href="@@url@@">@@header@@</a> @@price@@ %%eshop_currency%%</div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>'
    <hr>
</div>
"-->

<!--#set var="render_row(module=portfolio_item)" value="
<div class="ami_resp_row_##module##">
    <div>
        @@if(ext_img != '')@@<img src="@@ext_img@@" alt="" style="width: 150px;" />@@endif@@
        @@if(cat_header != '')@@<div class="ami_resp_row_cat_header_##module##">@@cat_header@@ </div>@@endif@@
        <div class="ami_resp_row_header_##module##"><a href="@@url@@">@@header@@</a></div>
    </div>
    <div class="ami_resp_row_announce_##module##">@@announce@@</div>
    <hr>
</div>
"-->

##-- ) row renderer description --##
##-- body renderer description ( --##

<!--#set var="body(module=articles);body(module=blog);body(module=eshop_item);body(module=files);body(module=kb_item);body(module=news);body(module=photoalbum);body(module=portfolio_item);body(module=stickers)" value="
<div id="ami_resp_outer_##id_block##" class="ami_resp_outer_##module##">
    <div class="ami_resp_navi" id="amiNav##id_block##">
        <div class="ami_resp_prev" id="amiNavPreviuos##id_block##" onClick="return o_##id_block##.previousPage();" title="%%navi_previous_page%%"></div>
        <div class="ami_resp_play_pause ami_resp_play_pause_disabled" id="amiNavPlayPause##id_block##" onClick="return o_##id_block##.playPause();" title="%%navi_play_pause%%"></div>
        <div class="ami_resp_next" id="amiNavNext##id_block##" onClick="return o_##id_block##.nextPage();" title="%%navi_next_page%%"></div>
        <div class="ami_resp_reload" id="amiNavReload##id_block##" onClick="return o_##id_block##.load();" title="%%navi_refresh%%"></div>
    </div>
    <div id="amiContent##id_block##"></div>
</div>
<div id="ami_resp_forbidden_##id_block##" style="display: none;">%%forbidden_module%%</div>
##js##
"-->

##-- ) body renderer description --##

<!--#set var="js" value="
<script type="text/amiro-template" id="itemRowTemplate_##id_block##"><!--##render_row##--></script>
<script type="text/javascript">
    var parameters = {
        id_plugin: '##id_plugin##',
        locale:    '##locale##',
        module:    '##module##',
        order:     '##order##',
        dir:       '##dir##',
        limit:     '##limit##',
        offset:    '##offset##',
        id_page:   '##id_page##'
    };

    if('##module##' == 'files'){
        AMI.Message.addListener('ON_AMI_LIST_DRAW_ROW', function(param1, param2){
            if(param1 == '##id_block##'){
                aFileTypes = {
                    1: 'archive', 2: 'binary', 3: 'word', 4: 'image',
                    5: 'movie', 6: 'pdf', 7: 'text', 8: 'excel',
                    9: 'html', 10: 'flash', 12: 'wave', 13: 'rm',
                    14: 'mp3', 15: 'powerpoint', 1000: 'other', 1001: 'chm'
                };
                if(typeof(param2['type']) != 'undefined' && typeof(aFileTypes[param2['type']]) != undefined){
                    param2['type'] = aFileTypes[param2['type']];
                }
            }
        });
    }

    var o_##id_block## = new AMI.UI.List('##id_block##', parameters);
    o_##id_block##.load();
</script>
"-->