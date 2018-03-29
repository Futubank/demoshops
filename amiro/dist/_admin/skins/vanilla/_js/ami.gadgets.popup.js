AMI.$('document').ready(function(){
   
    // Mouse over the title image
    AMI.$('.gadget_title_image').mouseover(function(){
            
            // (NotWork) Emulating mouseover at the text link (Somehow, style of the anchor dose not change, 
            // that why I've comment')       
            //var one_more_link=AMI.$(this).parent().siblings('a');
            //one_more_link.css('backgournd-color',"red");
            //one_more_link.css({'ext-decoration':'underline'});
            
          AMI.$(this).removeClass("img_opacity_yes");
          AMI.$(this).addClass("img_opacity_no");
    });  
    AMI.$('.gadget_title_image').mouseout(function(){ 
            // (NotWork)Emulating mouseover at the text link       
            //var one_more_link=AMI.$(this).parent().siblings('a');
            
        
          AMI.$(this).removeClass("img_opacity_no");
          AMI.$(this).addClass("img_opacity_yes");
    }); 
     
    // Mouse over the insert link, change Image Opacity
    AMI.$('.gadget_add_text_link').mouseover(function(){ 
          var cur_img=AMI.$(this).siblings('a').children('img');  
          cur_img.removeClass("img_opacity_yes");
          cur_img.addClass("img_opacity_no");
    });  
    AMI.$('.gadget_add_text_link').mouseout(function(){ 
            var cur_img=AMI.$(this).siblings('a').children('img');   
            cur_img.removeClass("img_opacity_no");
            cur_img.addClass("img_opacity_yes");
     }); 
     
    //  Mouse over the general div, were stored all current gadget information
    AMI.$('div.one_gadget').mouseover(function(){ 
          AMI.$(this).removeClass("one_gadget_mouseout");
          AMI.$(this).addClass("one_gadget_mouseover");
    });  
    AMI.$('div.one_gadget').mouseout(function(){ 
          AMI.$(this).removeClass("one_gadget_mouseover");
          AMI.$(this).addClass("one_gadget_mouseout");
     });   
    
});