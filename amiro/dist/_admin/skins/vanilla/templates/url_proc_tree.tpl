%%include_language "templates/lang/main.lng"%%
%%include_language "templates/tree/tree.lng"%%

<!--#set var="level_start" value=""-->

<!--#set var="level_end" value=""-->

<!--#set var="img_path" value="<img align="absmiddle" src="skins/vanilla/treeimgs/##img##.gif" >" -->

<!--#set var="img_inc" value="<img id="el_##cid##" title="##img_alt##" align="absmiddle" width=16 height=16 src="skins/vanilla/treeimgs/page_##img_foldermask##.gif">" -->

<!--#set var="img_link" value="<img align="absmiddle" src="skins/vanilla/treeimgs/##img##.gif" title="##alt##">"-->

<!--#set var="select_link" value="<a id="##cid##" href="#" onclick = "amiCommon.stopEvent(amiCommon.getValidEvent(event)); javascript:set_url('##cid##','##itemLink##');" title="%%Select Item%%" ><img id=el_##cid## align="absmiddle" src="skins/vanilla/treeimgs/page_##img_foldermask##.gif" ></a>"-->

<!--#set var="item_selected" value="<b>##itemName##</b>"-->

<!--#set var="item_normal" value="##itemName##"-->

<!--#set var="item" value="
     <tr valign="top">
       <td valign="top" nowrap>##lines##<span class="tree_item" id="tree_it_##cid##">##item##</span></td>
     </tr>
"-->

<script>
var img1 = new Image;
img1.src="skins/vanilla/treeimgs/page_0.gif";
var img2 = new Image;
img2.src="skins/vanilla/treeimgs/page_10.gif";
var img3 = new Image;
img3.src="skins/vanilla/treeimgs/page_100.gif";
var img4 = new Image;
img4.src="skins/vanilla/treeimgs/page_11.gif";
var img5 = new Image;
img5.src="skins/vanilla/treeimgs/page_110.gif";
var img6 = new Image;
img6.src="skins/vanilla/treeimgs/page_111.gif";
var img7 = new Image;
img7.src="skins/vanilla/treeimgs/minus.gif";
var img8= new Image;
img8.src="skins/vanilla/treeimgs/plus.gif";
var img9= new Image;
img9.src="skins/vanilla/treeimgs/joinbottom.gif";
var img10= new Image;
img10.src="skins/vanilla/treeimgs/line.gif";
var img11= new Image;
img11.src="skins/vanilla/treeimgs/join.gif";
var img12 = new Image;
img12.src="skins/vanilla/treeimgs/minusbottom.gif";
var img13 = new Image;
img13.src="skins/vanilla/treeimgs/plusbottom.gif";
var img14 = new Image;
img14.src="skins/vanilla/treeimgs/tf_0.gif";
var img15 = new Image;
img15.src="skins/vanilla/treeimgs/tf_1000.gif";
var img16 = new Image;
img16.src="skins/vanilla/treeimgs/tf_10000.gif";
var img17 = new Image;
img17.src="skins/vanilla/treeimgs/tf_11000.gif";
var img18 = new Image;
img18.src="skins/vanilla/images/bp_1.gif";
</script>

<table border=0 cellspacing=0 cellpadding=0 id="tree">
  <tr>
    <td>
      ##map##
    </td>
  </tr>
</table>