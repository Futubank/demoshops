CodeMirror.defineMode("amitpl", function(config, parserConfig) {
  
  var amiConstruction = '';
  
  var amitplOverlay = {

    startState: function(base) {
      return {amiConstruction: []};
    },
    
    token: function(stream, state) {
        /*if(stream.sol()){
            amiConstruction = '';
        }*/
        className = null;
        if(state.amiConstruction == ''){
            if(stream.match(/^##--/)){
                state.amiConstruction = amiConstruction = 'comment';
                return 'ami-comment';
            }else if(stream.match(/^%%include_(template|language)\s/i)){
                state.amiConstruction = amiConstruction = 'include';
                return 'ami-include';
            }else if(stream.match(/^<!--#set/i)){
                state.amiConstruction = amiConstruction = 'set';
                return 'ami-set';
            }else if(stream.match(/^"-->/)){
                return 'ami-set';
            }else if(stream.match(/^##set(?:global)?var\s+/i)){
                state.amiConstruction = amiConstruction = 'setvar';
                return 'ami-setvar';
            }else if(stream.match(/^##if\(/i) || stream.match(/^##else\s?if\(/i)){
                state.amiConstruction = amiConstruction = 'if';
                return 'ami-if';
            }else if(stream.match(/^##else##/i) || stream.match(/^##endif##/i)){
                return 'ami-if';
            }else if(stream.match(/^##__[A-Z_]+__##/)){
                return "ami-debug";
            }else if(stream.match(/^##/)){
                state.amiConstruction = amiConstruction = 'var';
                return "ami-var";
            }else if(stream.match(/^%%/i)){
                state.amiConstruction = amiConstruction = 'langvar';
                return 'ami-langvar';
            }else{
                stream.next();
            }
        }else{
            switch(state.amiConstruction){
                case 'include':className = 'ami-include';state.amiConstruction = amiConstruction = this.moveTo(stream, /^%%/) ? '' : amiConstruction;break;
                case 'set':state.amiConstruction = amiConstruction = this.moveTo(stream, /^var="/i) ? 'setname' : amiConstruction;break;
                case 'setname':className = 'ami-setname';stream.eatWhile(/[^"]/);state.amiConstruction = amiConstruction = '';break;
                case 'setvar':if(stream.match(/^##/)){className = 'ami-setvar';state.amiConstruction = amiConstruction = '';}else{stream.next();className = 'ami-setvar-expr';};break;
                case 'if':if(stream.match(/^\)##/)){className = 'ami-if';state.amiConstruction = amiConstruction = '';}else{stream.next();className = 'ami-if-expr';};break;
                case 'var':className = 'ami-var';state.amiConstruction = amiConstruction = this.moveTo(stream, /^##/) ? '' : amiConstruction;break;
                case 'langvar':className = 'ami-langvar';state.amiConstruction = amiConstruction = this.moveTo(stream, /^%%/) ? '' : amiConstruction;break;
                case 'comment':className = 'ami-comment';state.amiConstruction = amiConstruction = this.moveTo(stream, /^--##/) ? '' : amiConstruction;break;
            }
        }
        return className;
    },

    moveTo: function(stream, terminator) {
        var res = false;
        while(!stream.eol()){
            if(stream.match(terminator)){
                res = true;
                break;
            }
            stream.next();
        }
        return res;
    }
  };

  return CodeMirror.overlayParser(CodeMirror.getMode(config, parserConfig.backdrop || "text/html"), amitplOverlay);
});

CodeMirror.defineMode("amitplbb", function(config, parserConfig) {

  var amiConstruction = '';

  var amitplOverlay = {

    startState: function(base) {
      return {amiConstruction: []};
    },

    token: function(stream, state) {
        /*if(stream.sol()){
            amiConstruction = '';
        }*/
        className = null;
        var scRet = eval('"\\u21B5"'); // Return arrow
        var scSpc = eval('"\\u00B7"'); // Dot
        var specRegexp = new RegExp('^(' + scRet + '|' + scSpc + ')');
        if(state.amiConstruction == ''){
            if(stream.match(/^##/)){
                state.amiConstruction = amiConstruction = 'var';
                return "ami-var";
            }else if(stream.match(/^%%/i)){
                state.amiConstruction = amiConstruction = 'langvar';
                return 'ami-langvar';
            }else if(stream.match(/^\[RAW\]/i)){
                state.amiConstruction = amiConstruction = 'raw';
                return 'ami-raw';
            }else if(stream.match(specRegexp)){
                state.amiConstruction = amiConstruction = 'special';
                return 'ami-raw';
            }else if(stream.match(/^\[\/?(B|S|P|I|U|H1|H2|H3|H4|H5|DIV|LEFT|RIGHT|CENTER|JUSTIFY|INDENT|URL|IMG|OL|LIST|\*|Q|CODE|FONT|SIZE|COLOR)(\=[^\]]*?)?\]/i)){
                state.amiConstruction = amiConstruction = '';
                return 'ami-bb';
            }else{
                stream.next();
            }
        }else{
            switch(state.amiConstruction){
                case 'special':state.amiConstruction = amiConstruction = ''; break;
                case 'raw':className = 'ami-raw';state.amiConstruction = amiConstruction = this.moveTo(stream, /^\[\/RAW\]/i) ? '' : amiConstruction;break;
                case 'var':className = 'ami-var';state.amiConstruction = amiConstruction = this.moveTo(stream, /^##/) ? '' : amiConstruction;break;
                case 'langvar':className = 'ami-langvar';state.amiConstruction = amiConstruction = this.moveTo(stream, /^%%/) ? '' : amiConstruction;break;
            }
        }
        return className;
    },

    moveTo: function(stream, terminator) {
        var res = false;
        while(!stream.eol()){
            if(stream.match(terminator)){
                res = true;
                break;
            }
            stream.next();
        }
        return res;
    }
  };

  return CodeMirror.overlayParser(CodeMirror.getMode(config, parserConfig.backdrop || "text/html"), amitplOverlay);
});
