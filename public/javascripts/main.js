$(document).ready(function() {
  
  /* 
   * Current service being managed
   */
  var svc = null;
  
  /* 
   * Set up modal control dialog
   */
  $('#controls').jqm({overlay: 80});
  
  /* 
   * Bind all watches to the control dialog
   */
  $(".service").each(function() {
    $(this).bind("click", function() {
      svc = $(this).attr("id");
      $('#control_svc').text("Control:  " + svc);
      $('#svc_field').attr('value', svc);
      $('#controls').jqmShow();
    });
  });
  
});
