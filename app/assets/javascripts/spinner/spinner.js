  $(document).ready(function() {

    /*
    * Increase the value of the number entry field. If increasing 
    * the value takes it beyond the max then the field will "wrap"
    * and use the min value.
    *
    * Params:
    *   +id+ - The id for the field to increment the value of
    *   +max+ - The Maximum value for the field 
    *   +min+ - The minimum value for the field. Default 1.
    */
    function incVal(id, max, min = 1 ) {
      var val = parseInt($(id).val());
      if (val < max)
        $(id).val(val + 1);
      else if (val >= max)
        $(id).val(min);
    };


    /*
    * Decrease the value of the number entry field. If decreasing 
    * the value takes it below the min then the field will "wrap"
    * and use the max value.
    *
    * Params:
    *   +id+ - The id for the field to decrement the value of.
    *   +min+ - The Minimum value for the field 
    *   +max+ - The Maximum value for the field. Default 1.
    */
    function decVal(id, min, max = 12) {
      var val = parseInt($(id).val());
      if (val > min)
        $(id).val(val - 1);
      else if (val <= min)
        $(id).val(max);
    };

    /*
    * Update the time in the hidden time field, combining the elements
    * of the hour, min and second controls
    */
    function updateTime(name) {
      $("input[name=\"" + name +"_time\"]").val( $("#" + name + "_hour").val() +
        ":" +
        $("#" + name + "_t_min").val() +
        $("#" + name + "_z_min").val()
      )
      console.log( $("input[name=\"" + name + "_time\"]").attr("value") );
    }

    /*
    * Description:: 
    * Create a "Spinner" - an input box with an arrow above and below it.
    * Position and graphic are styled via spinner.css.
    *
    * Params::
    * +context+ - jQuery element on which to append the control
    * +name+ - 
    * +type+ - One of "hour" (hours), "t_min" (tens minutes) 
    *          or "z_min" (zingle minutes)
    *
    *
    */
    function _createSpinner(context, name, type, min = 1, max = 12) {
      var spinner = "<div class=\"" + type + " float\">";     // Opening Div
      // Top "Spinner" Arrow
      spinner += "<span class=\"up spin_control\" id=\""
        + name + "_" + type +"_up\"></span>";
      // Input field to hold the number
      spinner += "<input type=\"number\" min=\"1\" max=\"12\"" +
        " value=\"1\" class=\"float\" id=\"" + name + "_" + type + "\"/>";
      // Bottom "Spinner" Arrow
      spinner += "<span class=\"down spin_control\" id=\"" + 
        name + "_" + type + "_down\"></span>";
      spinner += "</div>";                                    // Closing Div

      // Append all "Spinner" elements to the control passed in the context
      $(context).append(spinner);

      // Increment Function
      $("#" + name + "_" + type +"_up").click(function(){
        incVal("#" + name + "_" + type, max, min);
        updateTime(name);
      });

      // Decrement Function
      $("#" + name + "_" + type + "_down").click(function(){
        decVal("#" + name + "_" + type, min, max);
        updateTime(name);
      });
    }

    /*
    * Dynamically create timer adding elements to the div where a div
    * is found which follows the pattern :
    *   <div name="**name**" class="time_picker"/>
    */
    $(".time_picker").each( function(i) {
      var name = $(this).attr("name");// start, end
      $(this).append("<input type=\"hidden\" name=\"" +
                     name + "_time\" value=\"0:00\"/>");
      _createSpinner(this, name, "hour" , 1, 12) ;
      $(this).append("<div class=\"seperator float\">:</div>");
      _createSpinner(this, name, "t_min", 0, 5) ;
      _createSpinner(this, name, "z_min", 0, 9) ;
    });
  });
