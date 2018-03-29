if (!AMI.Eshop)
	AMI.Eshop = {};
AMI.Eshop.Properties =	{
	//AMI.Eshop.Properties.aPropData is undefined by default,
	doesnt_matter : 'doesnt matter', // Default values, used if no &#037;&#037;locals&#037;&#037;
	chose_prop : 'chose prop',
	choose_another : 'chose another',
	
	property_id_name : 'itemD_property_', // Id prefix for fieldsets with eshop-item-properties of current property
	properties_block_classname : 'eshop-item-properties', // css class name for block (fieldset) with all eshop-item-properties of current property

	avail_ids : Array( 'ami-eshop-properties__availability', 'ami-eshop-properties__price-box' ), // id of blocks to be shown when variant is available (hidden when unavail)
	unavail_ids : Array( 'ami-eshop-properties__unavailable' ), // id of blocks to be shown when variant is unavailable (hidden when avail)

	/**
	 * Finding key blocks, inserting properties fields
	 */
	init : function()
	{
		if (this.aPropData) // global var aPropData, not this.
		{
            if (typeof eshop_properties_view == "undefined") {
                eshop_properties_view = 'radio';
            }
            if(eshop_properties_view == 'table') {
                var tablePropData = '<table class="ami-eshop-properties__wrapper-table" cellspacing="0" cellpadding="0">';
                var propValue = AMI.Eshop.Properties.aPropData;
                AMI.$('#ami-eshop-properties__price-box').css('display', 'none');
                
                for(i=0;i<propValue.length;i++) {
                        tablePropData += '<tr class="ami-eshop-properties__wrapper-table-tr__'+i+'">';
                        for(k=0;k<propValue[i].length;k++) {
                            if(propValue[i].length-1 == k) {
                                //
                            } else {
                                if(i == 0) {
                                    tablePropData += '<th>'+propValue[i][k]+'</th>';
                                } else {
                                    tablePropData += '<td>'+propValue[i][k]+'</td>';
                                }
                            }
                        }
                        tablePropData += '</tr>';
                }
                
                tablePropData += '</table>';
                AMI.$('.eshop-item-detailed__description:eq(0)').before(tablePropData);
            } else {
                this.price_box = document.getElementById('ami-eshop-properties__price-box'); // Block with price
                this.price_choice = document.getElementById('ami-eshop-properties__current-chosen-params-list'); // 
                this.price = this.price_box;
                this.unavail = document.getElementById('ami-eshop-properties__unavailable');
                
                this.avail_blocks = Array();
                for ( i = 0 ; i <= this.avail_ids.length - 1 ; i++ )
                {
                    var block = document.getElementById(this.avail_ids[i]);
                    if (block)
                        this.avail_blocks.push(block);
                }
                
                this.unavail_blocks = Array();
                for ( i = 0 ; i <= this.unavail_ids.length - 1 ; i++ )
                {
                    var block = document.getElementById(this.unavail_ids[i]);
                    if (block)
                        this.unavail_blocks.push(block);
                }
                
                this.prepareProperties();
                this.resetProperties();
                this.setProperty();
                
                if(eshop_properties_view == 'select') {
                    this.initSelectBox();
                }
            }
		}
	},

	/**
	 * Returning true if THIS is IE version or lower
	 */
	ie : function(version)
	{
		var rv;
		var ua = navigator.userAgent;
		var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
			rv = parseFloat( RegExp.$1 );
		return (navigator.appName == "Microsoft Internet Explorer") && (rv <= version);
	},

	/**
	 * Update all eshop-item-properties, by deleting and inserting all of them
	 *
	 * @propNum - property number, eshop-item-properties of which will be updated
	 * @allowedValues - all allowed eshop-item-properties of propNum property
	 * @allValues - all eshop-item-properties of propNum property
	 * @clickedPropNum - last clocked property, can be any value
	 */
	propertyValuesSet : function(propNum, allowedValues, allValues, clickedPropNum)
	{
		var fieldSet = document.getElementById(this.property_id_name + propNum); // Finding fieldset for property propNum
		var sValue, legend;
		var selectedIndex = -1;
		var i;

		var radios = fieldSet.getElementsByTagName("input"); // All radios in current fieldset
		if (typeof radios != 'undefined' && typeof radios.length === 'number' && radios.length > 0) // There must be at least one radio
		{
			for ( i = 0 ; i <= radios.length - 1 ; i++ )
			{
				if (radios[i].checked)
				{
					selectedIndex = i;
					break;
				}
			}
			
			if (selectedIndex < radios.length && selectedIndex >= 0) // FF3.0 generating error if selectedIndex is "-1"
			{
				if (typeof radios[selectedIndex] != 'undefined' && typeof radios[selectedIndex].value === 'string')
					sValue = radios[selectedIndex].value;
			}
			
			// Finding actual index (in allValues array) of checked element
			for ( i = 0 ; i <= allValues.length - 1 ; i++ )
			{
				if (sValue == allValues[i])
				{
					selectedIndex = i;
				}
			}
			
			// Deleting all radios
			for ( i = radios.length - 1 ; i >= 0 ; i-- )
				fieldSet.removeChild(radios[i]);
		}
		else // For first execution (for example, when page is loaded)
		{
			for ( i = 0 ; i <= allValues.length - 1 ; i++ )
			{
				if (this.inArray(allowedValues, allValues[i]))
				{
					selectedIndex = i;
					break;
				}
					
			}
			//selectedIndex = i;
		}
		
		
		// Deleting all labels and brs...
		labels = fieldSet.getElementsByTagName("label"); // Only one label per radio allowed
		brs = fieldSet.getElementsByTagName("br");
		
		if (typeof labels != 'undefined')
			for ( i = labels.length - 1 ; i >= 0 ; i-- )
				fieldSet.removeChild(labels[i]);
		if (typeof brs != 'undefined')
			for ( i = brs.length - 1 ; i >= 0 ; i-- )
				fieldSet.removeChild(brs[i]);
		
		// ... and creating them all over again
		for ( i = 0 ; i < allValues.length ; i++ )
		{
			if ( this.ie(6) )
			{
				var input = document.createElement('<input name=' + fieldSet.id + '>');
			}
			else
			{
				var input = document.createElement('input'); // Creating new radio
				input.name = fieldSet.id; // Uniting radios by parent fieldset id
			}
			label = document.createElement('label'); // Creating label for radio
			input.id = 'fieldset_' + fieldSet.id + '_radio_' + i;
			input.type = "radio";
			input.value = allValues[i];
			input.checked = false;
			input.defaultChecked = false;
			input.setAttribute("class", this.properties_block_classname + "__radio");
			label.setAttribute("class", this.properties_block_classname + "__label");
			if (!this.inArray(allowedValues, allValues[i])) // Blocks element if value not allowed
			{
				input.setAttribute("class", this.properties_block_classname + "__radio " + this.properties_block_classname + "_disabled");
				label.setAttribute("class", this.properties_block_classname + "__label " + this.properties_block_classname + "_disabled");
				if (this.ie(6))
				{
					//input.disabled = true;
					label.disabled = true;
				}
				if ( i == selectedIndex ) // Unavailabled value is checked
				{
					input.checked = true;
					input.defaultChecked = true;
					fieldSet.className = this.properties_block_classname + ' ' + this.properties_block_classname + '_notavail';
					legend = fieldSet.getElementsByTagName("legend")[0];
				}
			}
			else
			{
				if ( i == selectedIndex )
				{
					input.checked = true;
					input.defaultChecked = true;
					fieldSet.className = this.properties_block_classname;
				}
			}
			fieldSet.appendChild(input);

			input.onclick = function(LocalPropNum, Obj) { // Onclick handler
				return function() // Actually onclick handler
				{
					Obj.setProperty(LocalPropNum, this.value);
				}
				
			}(propNum, this) // "this" - object-class that has function setProperty()
			
			if (clickedPropNum === propNum && input.checked)
				label.setAttribute("class", this.properties_block_classname + "__label " + this.properties_block_classname + "__label_visited");
			label.htmlFor = input.id;
			label.innerHTML = input.value;
			if (label.innerHTML === '')
			{
				label.className += " " + this.properties_block_classname + "__label_value_notset";
				label.innerHTML = this.doesnt_matter;
			}
			
			fieldSet.appendChild(label);
			fieldSet.appendChild(document.createElement('br'));
			
		}
		return true;
	},
	
	/**
	 * Existance of value in array
	 *
	 * @aArray - one-dimensional array
	 * @sValue - value
	 */
	inArray : function(aArray, sValue)
	{
		for ( var i = 0 ; i < aArray.length ; i++ )
		{
			if ( aArray[i] == sValue )
			{
				return true;
			}
		}
		return false;
	},

	
	/**
	 * Allowed eshop-item-properties of property
	 *
	 * @getPropNum - property number (html dimension)
	 * @priorityOrder - Array of priorities. Index is property number, priorityOrder[index] is priority of index property
	 */
	getAllowedPropertyValues : function(getPropNum, priorityOrder)
	{
		var aValues = Array();
		var enabled;
		var fieldSet;
		var i, j, k;
		var selectedValue = []; // in priority dimension
		var radios = [];
		var inversePriorityOrder = []; // index is priority, value[index] - property number
		var orderedPropNum; // property number in ierarchy dimension
		
		// Making inverse priority array
		for ( i = 0 ; i <= priorityOrder.length - 1 ; i++ )
		{
			//while (  ) {j++}
			inversePriorityOrder[ priorityOrder[i] ] = i;
		}
		
		orderedPropNum = priorityOrder[getPropNum];
		if (getPropNum >= 0 && getPropNum <= priorityOrder.length && typeof priorityOrder[getPropNum] != 'undefined')
		{
			orderedPropNum = priorityOrder[getPropNum];
		}
		else // Impossible, delete that
		{
		
		}
		
		// Finding ckecked eshop-item-properties of more important custom fieldss
		for ( i = 0 ; i <= this.aPropData[0].length - 3 ; i++ ) // html dimension
		{
			fieldSet = document.getElementById(this.property_id_name + i); // fieldset for i-property
			if (typeof fieldSet != 'undefined' && fieldSet)
			{
				radios = fieldSet.getElementsByTagName("input"); // All radios in i-fieldset
				if (typeof radios != 'undefined' && radios.length > 0)
				{
					for ( j = 0 ; j <= radios.length - 1 ; j++ )
					{
						if (radios[j].checked)
						{
							selectedValue[priorityOrder[i]] = radios[j].value;
							break;
						}
					}
				}
			}
		}
		
		for ( i = 1 ; i < this.aPropData.length - 1 ; i++ ) // Rules
		{
			enabled = true; // Default state - variant allowed
			for ( j = 0 ; j <= orderedPropNum - 1 ; j++ ) // 'priority' dimension
			{
				if (this.aPropData[i][inversePriorityOrder[j]] != selectedValue[j])
					enabled = false;
			}
				
			if (enabled && !this.inArray(aValues, this.aPropData[i][getPropNum]))
				aValues[aValues.length] = this.aPropData[i][getPropNum];
		}
		
		//return aValues.sort();
		return aValues;
	},
	
	/**
	 * All eshop-item-properties of custom field
	 *
	 * @colNum - property number
	 */
	getAllPropertyValues : function(colNum)
	{
		var allValues = Array();
		
		for ( var i = 1 ; i < this.aPropData.length - 1 ; i++ )
		{
			if ( !this.inArray(allValues, this.aPropData[i][colNum]) )
			{
				allValues[allValues.length] = this.aPropData[i][colNum];
			}
		}
		
		//return allValues.sort();
		return allValues;
	},
	
	/**
	 * Makes propNum to highest priority
	 *
	 * @propNum - property that need to be highest priority
	 * @priorityOrder - Array of priorities. Index is property number, priorityOrder[index] is priority of index property
	 * @return - Array of priorities with 'highest priority' on 'propNum', or same array if any error occures
	 */
	setHighestPriority : function(propNum, priorityOrder)
	{
		var i, temp, hpi;
		for ( i = 0 ; i <= priorityOrder.length - 1 ; i++ )
		{
			priorityOrder[i] = i;
		}
		if (typeof propNum === 'number' && propNum >= 0 && propNum < priorityOrder.length && typeof priorityOrder[propNum] != 'undefined')
		{
			k = 1;
			for ( i = 0 ; i <= priorityOrder.length - 1 ; i++ )
			{
				priorityOrder[i] = i + k;
				if ( i ==  propNum)
				{
					priorityOrder[i] = 0;
					k = 0;
				}
			}
			
		}
		
		return priorityOrder;
	},
	
	/**
	 * Changes price when clicked in radio
	 *
	 * First execution takes place on page load
	 * @propNum - changed property number
	 * @propValue - new variant of property propNum
	 */
	setProperty : function(propNum, propValue)
	{
		var allowedValues;
		var allValues;
		var Avail;
		var i, firstExec = false, str, value;
		
		if ( this.aPropData && ( this.aPropData.length > 1 ) )
		{
			if (typeof propNum == 'undefined')
			{
				propNum = 0; // First property by default
				propValue = this.aPropData[1][propNum]; // Property value from first rule by default
				firstExec = true;
			}
			
			priorityOrder = this.setHighestPriority(propNum, priorityOrder);
		   
			for ( var j = 0 ; j <= this.aPropData[0].length - 3 ; j++ ) // Properties
			{
				allowedValues = this.getAllowedPropertyValues(j, priorityOrder);
				allValues = this.getAllPropertyValues(j);
				this.propertyValuesSet(j, allowedValues, allValues, propNum); // Rewriting allowed values of property j
			}
			
			// For first execution we need actual value of (let it be first) property
			if (firstExec)
			{
				var fieldSet = document.getElementById(this.property_id_name + 0); // Let it be first property
				var radios = fieldSet.getElementsByTagName("input");
				if (typeof radios != 'undefined')
				{
					i = 0;
					while(typeof radios[i] != 'undefined' && !radios[i].checked) {i++;}
				}
				propNum = i;
				propValue = radios[i].value;
			}
			
			for ( var i = 1 ; i <= this.aPropData.length - 1 ; i++ ) // Rules
			{
				if ( this.aPropData[i][propNum] == propValue )
				{
					//propNum = getProperty(); // Extract current properties values from radio (needed for first execution, when propNum undefined)
					var bFound = true;
					Avail = true; // Availability of product
					for ( var j = 0 ; j < this.aPropData[i].length - 2 ; j++ )
					{
						var oProperty = document.getElementById(this.property_id_name+j);
						if (typeof oProperty != 'undefined')
						{
							var radios = oProperty.getElementsByTagName("input");
							if (this.ie(6))
								var labels = oProperty.getElementsByTagName("label"); // for ie6
						}
						if (typeof radios != 'undefined') // if not first execution
						{
							for ( var k = 0 ; k <= radios.length - 1 ; k++ )
							{
								if ( radios[k].checked )
									break;
							}
							if (typeof radios[k] != 'undefined' && radios[k].className == this.properties_block_classname + '__radio ' + this.properties_block_classname + '_disabled')
							{
								Avail = false;
							}
							if (this.ie(6))
								if (typeof labels[k] != 'undefined' && labels[k].disabled)
									Avail = false;
							if (typeof radios[k] != 'undefined' && typeof radios[k].value == 'string')
							{
								if ( radios[k].value != this.aPropData[i][j] )
								{
									bFound = false;
								}
							}
						}
						else
							bFound = false;
					}
					// Changing current choice
					str = this.getChoice(this.aPropData[0].length - 2);
					if (typeof this.price_choice != 'undefined')
					{
						pricesAvailability = document.getElementById('prices-avaliability');
						lastPrice = '';
						this.price_choice.innerHTML = str;
					}
					// Changing price
					if ( bFound )
					{
						if (typeof this.price_box != 'undefined')
						{
							pricesAvailability = document.getElementById('prices-avaliability');
							lastPrice = '';
							this.price_choice.innerHTML = str;
							this.price_box.innerHTML = this.aPropData[i][this.aPropData[i].length - 2];
							if (pricesAvailability)
							{
								this.price_box.innerHTML = pricesAvailability.innerHTML + this.price_box.innerHTML;
								lastPrice = pricesAvailability.innerHTML;
							}
							
							
							lastPrice += this.aPropData[i][this.aPropData[i].length - 2];
							
							// Hiding unavail blocks
							for ( var m = 0 ; m <= this.unavail_blocks.length - 1 ; m++ )
							{
								this.unavail_blocks[m].style.visibility = 'hidden';
								this.unavail_blocks[m].style.opacity = '0.0';
							}
							// Showing avail blocks
							for ( m = 0 ; m <= this.avail_blocks.length - 1 ; m++ )
							{
								this.avail_blocks[m].style.visibility = 'visible';
								this.avail_blocks[m].style.opacity = '1.0';
							}
							
							if (typeof this.price_box != 'undefined')
							{
								/*this.price_box.style.visibility = 'visible';
								this.price_box.style.opacity = '1.0';
								this.unavail.style.visibility = 'hidden';
								this.unavail.style.opacity = '0.0';*/
								if (this.ie(8))
								{
									this.price_box.style.display = 'block';
									this.unavail.style.display = 'none';
									this.unavail.style.position = 'static';
								}
							}
						}
						else
							throw {message: "this.price_box is null"}
					}
					if (!Avail)
					{
						if (typeof this.price_box != 'undefined')
						{
							/*this.price_box.style.visibility = 'hidden';
							this.price_box.style.opacity = '0.0';
							this.unavail.style.visibility = 'visible';
							this.unavail.style.opacity = '1.0';*/
							// Showing unavail blocks
							for ( var m = 0 ; m <= this.unavail_blocks.length - 1 ; m++ )
							{
								this.unavail_blocks[m].style.visibility = 'visible';
								this.unavail_blocks[m].style.opacity = '1.0';
							}
							// Hiding avail blocks
							for ( m = 0 ; m <= this.avail_blocks.length - 1 ; m++ )
							{
								this.avail_blocks[m].style.visibility = 'hidden';
								this.avail_blocks[m].style.opacity = '0.0';
							}
							if (this.ie(8))
							{
								this.price_box.style.display = 'none';
								this.unavail.style.display = 'block';
								this.unavail.style.position = 'static';
							}
						}
					}
				}
			}
		}
	},
	
	/**
	 * Preparing and returns string of current fieldsets choise
	 *
	 * @propertiesNum - total number of properties
	 */
	getChoice : function(propertiesNum)
	{
		var fieldSet, radios, i, j, str = '<div class="chosen-properties"><div class="chosen-properties__header">' + this.chose_prop + ':</div>', value;
		
		for ( i = 0 ; i <= propertiesNum - 1 ; i++ )
		{
			fieldSet = document.getElementById(this.property_id_name + i);
			if (typeof fieldSet != 'undefined' && fieldSet)
				radios = fieldSet.getElementsByTagName('input');
			j = 0;
			while (typeof radios[j] != 'undefined' && !radios[j].checked) {j++} // Find checked radio of i-property
			//j--;
			str += '<div class="chosen-properties__property">' + fieldSet.getElementsByTagName('legend')[0].innerHTML + '</div>';
			value = radios[j].value;
			if (value == '')
				value = '<i>' + this.doesnt_matter + '</i>';
			if (this.isDisabled(radios[j]))
				str += '<div class="chosen-properties__value chosen-properties__value_disabled">' + value + '</div>';
			else
				str += '<div class="chosen-properties__value">' + value + '</div>';
			
		}
		
		
		
		return str + '</div>';
	},
	
	/**
	 * Checks if CSS classes intend to 'disable' element
	 */
	isDisabled : function(element)
	{
		return (element.className.indexOf("disabled") != -1);
	},

	/**
	 * Writing empty itemD_property_ containers for eshop-item-properties to document
	 */
	prepareProperties : function()
	{
		if ( this.aPropData && ( this.aPropData.length > 1 ) ) // Creating properties containers only if we received data from server
		{
			for ( var i = 0 ; i < this.aPropData[0].length - 2 ; i++ )
			{
				var wrapper = document.getElementById(this.wrapperId);
				wrapper.innerHTML += '<fieldset class="' + this.properties_block_classname + '" id="itemD_property_' + i + '" name="property_' + i + '"><legend class="' + this.properties_block_classname + '__header" title="' + this.choose_another + '">' + this.aPropData[0][i] + '</legend></fieldset>';
			}
		}
	},
	
	/**
	 * Reset all radios, emulating page reload
	 */
	resetProperties : function()
	{
		// Resetting radios
		var i, j, fieldSet, radios;
		for ( i = 1 ; i <= this.aPropData[0].length - 2 ; i++ )
		{
			fieldSet = document.getElementById(this.property_id_name + i);
			if (typeof fieldSet != 'undefined' && fieldSet)
			{
				radios = fieldSet.getElementsByTagName("input"); // All the radios in current fieldset
				if (typeof radios != 'undefined' && radios && typeof radios.length === 'number' && radios.length > 0)
				{
					for ( j = 0 ; j <= radios.length - 1 ; j++ )
					{
						radios[j].checked = false;
						radios[j].defaultChecked = false;
					}
				}
			}
		}
		
		// Resetting priority order
		priorityOrder = new Array();
		for ( i = 0 ; i <= this.aPropData[0].length - 3 ; i++ )
			priorityOrder[i] = i;
	},
    useSelectbox: function(radiobuttonAreaName, selectboxAreaName) {
        if(AMI.$('#'+selectboxAreaName).length == 0) {
            AMI.$('#'+radiobuttonAreaName).after('<div id="'+selectboxAreaName+'"></div>');
            AMI.$('#'+radiobuttonAreaName).css('display', 'none');
        }
        radiobuttonArea = AMI.$('#'+radiobuttonAreaName);
        selectboxArea = AMI.$('#'+selectboxAreaName);
        selectboxArea.html('');
        radiobuttonArea.find('.eshop-item-properties').each(function(i) {
			if(AMI.$(this).hasClass('eshop-item-properties_notavail')) {
				validSelect = 'class="eshop-item-properties_notavail__select" style="border: 1px solid #ff0000"';
			} else {
				validSelect = 'class="eshop-item-properties__select"';
			}
            selectboxArea.append('<div class="'+selectboxAreaName+'__block"><span class="'+selectboxAreaName+'__title">'+AMI.$(this).find('legend').text()+': </span><select '+validSelect+' onchange="AMI.Eshop.Properties.setSelectBox(this.value)" id="'+selectboxAreaName+'__'+i+'"></select></div>');
            AMI.$(this).find('input').each(function(k) {
                if(AMI.$(this).val() == '') {
                    optionValue = AMI.Eshop.Properties.doesnt_matter;
                } else {
                    optionValue = AMI.$(this).val();
                }
                if(AMI.$(this).hasClass("eshop-item-properties_disabled")) {
                    AMI.$('#'+selectboxAreaName+'__'+i).append('<option class="eshop-item-properties_disabled__option" style="background: #F5F5F5; color: #ccc;" value="'+AMI.$(this).attr('id')+'">'+optionValue+'</option>');
                } else {
                    AMI.$('#'+selectboxAreaName+'__'+i).append('<option class="eshop-item-properties__option" value="'+AMI.$(this).attr('id')+'">'+optionValue+'</option>');
                }
            });
        });
    },
    setSelectBox: function(value) {
        AMI.$('#'+value).attr('checked', 'checked');
        AMI.$('#'+value).click();
        this.initSelectBox();
        
        AMI.$('#ami-eshop-properties__wrapper input').each(function(i) {
            if(AMI.$(this).attr('checked') == 'checked') {
                AMI.$('#ami-eshop-properties__wrapper-selectbox option[value='+AMI.$(this).attr('id')+']').attr('selected', 'selected');
            }
        });
    },
    initSelectBox: function() {
        var radiobuttonAreaName = 'ami-eshop-properties__wrapper';
        var selectboxAreaName = 'ami-eshop-properties__wrapper-selectbox';
        this.useSelectbox(radiobuttonAreaName, selectboxAreaName);
    }
}

AMI.$(document).ready(function(){ AMI.Eshop.Properties.init(); });