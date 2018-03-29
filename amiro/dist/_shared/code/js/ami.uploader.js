/**
* @fileOverview File contains AMI.Uploader class.
*/

/**
* Class that creates a file upload field for async file upload.
* @example <strong>Example of using AMI.Uploader:</strong>
* <div id="fileUploader"></div>
* <script>
* var oUploadField = new AMI.Uploader('fieldName', AMI.find('#fileUploader'), 'current value.txt');
* </script>
*
* @class Async file upload class
*/

AMI.Uploader = function(name, object, filename){

    /**
     * Uploader container
     */
    this.container = object;

    /**
     * Field name
     */
    this.name = name;

    /**
     * Container for file name
     */
    this.fileNameContainer = null;

    /**
     * Field that contains file code
     */
    this.fileCodeField = null;

    /**
     * Upload file field
     */
    this.uploadField = null;

    /**
     * File upload form
     */
    this.form = null;

    /**
     * Iframe, target for file upload form submission
     */
    this.iframe = null;

    /**
     * Container that hides iframe
     */
    this.iframeContainer = null;

    /**
     * Container, that holds file upload fields
     */
    this.uploader = null;

    /**
     * Div that contains file upload form
     */
    this.uploadDialog = null;

    /**
     * Current state of the field ("select", "loading", "uploaded", "error")
     */
    this.state = 'select';

    /**
     * Current filename
     */
    this.filename = filename ? filename : '';

    /**
     * Uploading check timer
     */
    this.checkTimer = null;

    /**
     * Field validators
     */
    this.validators = null;

    /**
     * Delete file button
     */
    this.deleteBtn = null;

    /**
     * Initialize field.
     */
    this.init = function(){

        this.rebuildField();

        if(this.filename){
            this.setUploaded('uploaded', this.filename);
        }
    }

    /**
     * Rebuild whole field
     */
    this.rebuildField = function(){

        // Clear container
        this.container.innerHTML = '';

        var uploader = document.createElement('DIV');
        uploader.className = 'amiFileUploader';

        var deleteBtn = document.createElement('img');
        deleteBtn.className = 'amiFileUploaderDeleteBtn icon';
		deleteBtn.src = 'skins/vanilla/images/download_del_btn.png';
		
        var deleteBtnA = document.createElement('a');
        deleteBtnA.href = '#';
		deleteBtnA.style.float = 'left';
		deleteBtnA.setAttribute('onclick', 'return false');
		
        var fileNameContainer = document.createElement('DIV');
        fileNameContainer.className = 'fileNameContainer';

        var fileCodeField = document.createElement('INPUT');
        fileCodeField.type = 'hidden';
        fileCodeField.name = this.name;
        fileCodeField.value = '';

        var divIFrame = document.createElement('DIV');
        divIFrame.style.overflow = 'hidden';
        divIFrame.style.width = '310px';
		//divIFrame.id = 'input_file_' + this.name;
		divIFrame.className = 'input_file';
        divIFrame.style.height = '25px';
        divIFrame.style.top = '0px'
        divIFrame.style.left = '0px'
		divIFrame.style.zIndex = '5';
		divIFrame.setAttribute("onmouseover", "if (AMI.find('.download_img')[0]) AMI.find('.download_img')[0].className = 'download_img_hover'");
		divIFrame.setAttribute("onmouseout", "if (AMI.find('.download_img_hover')[0]) AMI.find('.download_img_hover')[0].className = 'download_img'");	
        this.iframeContainer = divIFrame;

		var inputFile = document.createElement('input');
		inputFile.className = 'field field50 download_file';
        this.inputFile = inputFile;
		
		var closeImg = document.createElement('div');
		closeImg.className = 'download_img icon';
		this.closeImg = closeImg;

        var formIFrame = document.createElement('IFRAME');
        var frameName = 'upload_frame_' + this.name;
        formIFrame.setAttribute('src', 'uploader.php');
        formIFrame.frameborder = '0';
        formIFrame.style.border = '0px solid white';
        formIFrame.name = frameName;
        formIFrame.uploader = this;
        this.iframe = formIFrame;

        divIFrame.appendChild(formIFrame);

        this.fileNameContainer = fileNameContainer;
        this.fileCodeField = fileCodeField;

        uploader.appendChild(fileNameContainer);
        uploader.appendChild(fileCodeField);
        uploader.appendChild(divIFrame);
		uploader.appendChild(inputFile);
		uploader.appendChild(closeImg);

        this.deleteBtn = deleteBtn;
        this.uploader = uploader;
        this.container.appendChild(uploader);
        this.container.appendChild(deleteBtnA);		
        deleteBtnA.appendChild(deleteBtn);
        

        AMI.Browser.Event.addHandler(deleteBtn, 'click', function(_this){
            return function(e){
                if(_this.state != 'select'){
                    _this.rebuildField();
                }
            }
        }(this));

        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }

        if(this.validators){
            this.setValidators(this.validators);
        }

        this.clear();
    }

    /**
     * Checks if file was not uploaded.
     */
    this.checkDocument = function(){
        if(this.state == 'loading'){
            try{
                if(this.iframe.contentWindow && (typeof(this.iframe.contentWindow.document) != 'undefined') && !this.iframe.contentWindow.loading){
                    this.setError();
                }
            }catch(e){
                this.setError();
            }
        }else{
            if(this.checkTimer){
                clearInterval(this.checkTimer);
                this.checkTimer = null;
            }
        }
    }

    /**
     * Clears current field state.
     */
    this.clear = function(){
        this.state = 'select';
        AMI.removeClass(this.fileNameContainer, 'error');
        AMI.removeClass(this.fileNameContainer, 'loading');
        AMI.removeClass(this.fileNameContainer, 'uploaded');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = AMI.Template.Locale.get('select_file');
        this.fileNameContainer.style.display = 'none';
        this.iframeContainer.style.display = 'block';
        this.deleteBtn.style.display = 'none';
		this.closeImg.style.display = 'inline';
		this.inputFile.style.display = 'inline';
    }

    /**
     * Sets field to uploaded state.
     *
     * @param {string} code File internal code
     * @param {string} filename  File real filename
     */
    this.setUploaded = function(code, filename, size){
        size = (typeof(size) == 'undefined') ? '' : (' (' + size + ')');
        AMI.Message.send('ON_FILE_UPLOADED', this, {'code': code, 'name': filename});
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }
        this.state = 'uploaded';
        AMI.removeClass(this.fileNameContainer, 'error');
        AMI.removeClass(this.fileNameContainer, 'loading');
        this.fileCodeField.value = code;
        this.fileNameContainer.innerHTML = filename.replace(/\\'/g, "'") + size;
        AMI.addClass(this.fileNameContainer, 'uploaded');
        this.deleteBtn.style.display = 'block';
		this.closeImg.style.display = 'none';
		this.inputFile.style.display = 'none';
    }

    /**
     * Marks field as error.
     */
    this.setError = function(errorMsg){
        if(this.checkTimer){
            clearInterval(this.checkTimer);
            this.checkTimer = null;
        }
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        this.state = 'error';
        AMI.removeClass(this.fileNameContainer, 'uploaded');
        AMI.removeClass(this.fileNameContainer, 'loading');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = (typeof(errorMsg) != 'undefined') ? errorMsg : AMI.Template.Locale.get('upload_failed');
        AMI.addClass(this.fileNameContainer, 'error');
        this.deleteBtn.style.display = 'block';
    }

    /**
     * Set field to loading state.
     */
    this.setLoading = function(){
        this.iframeContainer.style.display = 'none';
        this.fileNameContainer.style.display = 'block';
        this.iframe.contentWindow.loading = true;

        // Check loading state every 10 seconds
        this.checkTimer = setInterval(function(_this){
            return function(){
                _this.checkDocument();
            }
        }(this), 10000);
        this.state = 'loading';
        AMI.removeClass(this.fileNameContainer, 'uploaded');
        AMI.removeClass(this.fileNameContainer, 'error');
        this.fileCodeField.value = '';
        this.fileNameContainer.innerHTML = AMI.Template.Locale.get('upload_in_progress');
        AMI.addClass(this.fileNameContainer, 'loading');
        this.deleteBtn.style.display = 'block';
		this.closeImg.style.display = 'none';
		this.inputFile.style.display = 'none';
    }

    /**
     * Sets field validators.
     *
     * @param {string} validators List of validators
     */
    this.setValidators = function(validators){
        this.fileCodeField.setAttribute('data-ami-validators', validators);
        this.validators = validators;
    }

    this.init();
}