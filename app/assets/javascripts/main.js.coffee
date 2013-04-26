System =
  controller: null,
  action: null
  
Page =
  lot:
    certificate:
      records_added: [],
      records_already_added: []
  
Init =
  main:
    dashboard: ->
      # Sorting 
      $('th').live 'click', (evt) ->
        if $(this).hasClass('sort')
          for_data = $(this).parents('table').attr('id')
          url = $(this).find('a').attr('href') + '&dataset=' + for_data
          url = url.replace('/dashboard','/dashboard.js')
          $.get url
#        return false
      # Make sure first tab is showing
      $('.event-container li.first').trigger 'click'
      # Resize the viewport based on window
      window_resize()
      
    options: ->
      $('#revalidate-data-button').bind 'click', (evt) ->
        if(confirm('Are you sure? This could take up to 10 minutes to complete. Other users will not be able to use the application while revalidation takes place.'))
          $('form').bind 'ajax:complete', (evt) -> 
            $('p.notice').text 'Data revalidation complete.'
            if_notice()
            #$('#revalidate-data-button').attr 'disabled', nil
            $('#revalidate-data-button').css 'alpha', 1
            $('#revalidate-data-button').val 'Revalidate data'
            $('form').unbind 'ajax:complete'
          $('p.notice').text 'Revalidating / polling quality assurance data...'
          if_notice()
          $('#revalidate-data-button').css 'alpha', 0.5
          $('#revalidate-data-button').val 'Please wait...'
          #$('#revalidate-data-button').attr 'disabled','disabled'
          return true
          
  quality:
    show: ->
      lab_method_id = $('#quality_lab_method_id').val()
      if(lab_method_id)
        $.getJSON('/lab_methods/' + lab_method_id + '.json', 
          (data) ->
            if data.temperature
              $('.bar-temperature').show() 
            else 
              $('.bar-temperature').hide()
              
            if data.moisture
              $('.bar-moisture').show() 
            else 
              $('.bar-moisture').hide()
      
            if data.solids
              $('.bar-solids').show() 
            else 
              $('.bar-solids').hide()
              
            if data.bulk_density
              $('.bar-bulk-density').show() 
            else 
              $('.bar-bulk-density').hide()
              
            window_resize()
        )
      return
      
    edit: ->
      $('#review-button').on 'click', ->
        if($('#quality_lab_method_id').val().toString() != '' && $('#quality_product_id').val().toString() != '' && $('#quality_color_l').val().toString() != '' && $('#quality_color_a').val().toString() != '' && $('#quality_color_b').val().toString() != '' && $('#quality_viscosity').val().toString() != '' && $('#quality_lot').val().toString() != '' && $('#quality_julian_date').val().toString() != '' && $('#quality_tank').val().toString() != '' && $('#quality_skid').val().toString() != '' &&  $('#quality_starch_lot').val().toString() != '' && $('#quality_temperature').val().toString() != '' && $('#quality_solids').val().toString() != '' && $('#quality_moisture').val().toString() != '' && $('#quality_bulk_density').val().toString() != '')
          if $('#quality_lab_method_id').val().toString() == '1'
            if ($('#quality_solids').val() >= 24 && $('#quality_solids').val() <= 28) && ($('#quality_temperature').val() >= 20 && $('#quality_temperature').val() <= 29)
              $.post('/quality-assurance/modal', $('form').serialize(), (data) ->
                $('.modal').html(data)
                $('.modal').show()
                $('.modal .dialog').hide().delay(100).css({top:'-400px'}).show().animate({top:'-1px'},200)
              )
              return false
            else
              return true
          else if $('#quality_lab_method_id').val().toString() == '2'
            if $('#quality_solids').val() >= 16.5 && $('#quality_solids').val() <= 18.5
              $.post('/quality-assurance/modal', $('form').serialize(), (data) ->
                $('.modal').html(data)
                $('.modal').show()
                $('.modal .dialog').hide().delay(100).css({top:'-400px'}).show().animate({top:'-1px'},200)
              )
              return false
            else
              return true
          
      $('a.edit-link').live 'click', ->
        $('.modal .dialog').delay(100).animate({top:'-400px'},200, ->
          setTimeout $(this).hide(), 200
          setTimeout $('.modal').hide(), 400
        )
        return false
    
      $('#quality_lot,#quality_starch_lot').on 'change', ->
        $(this).val $(this).val().toUpperCase()
        
      $('#quality_tank,#quality_skid,#quality_julian_date,#quality_temperature,#quality_viscosity,#quality_color_l,#quality_color_a,#quality_color_c,#quality_solids,#quality_moisture,#quality_bulk_density').on 'change', ->
        if isNaN(parseFloat($(this).val())) 
          $(this).val('')
      
      $('.datepicker').datepicker({'dateFormat':'yy-mm-dd'})
      $('#quality_lot').mask('aa99999a')
      $('#quality_julian_date').mask('999')
      $('#quality_tank').mask('9?99')
      $('#quality_skid').mask('9?99')
      #$('#quality_viscosity,#quality_temperature,#quality_color_l,#quality_color_a,#quality_color_b').mask('99?9.9')
      #$('#quality_moisture').mask('9?99.99')
      #$('#quality_bulk_density').mask('9?99.9')
      #$('#quality_solids').mask('99.9?9')
      
      $('#quality_lab_method_id').on 'change', -> #shows/hides secondary quality input items
        if($(this).val())
          $.getJSON('/lab_methods/' + $(this).val() + '.json', 
            (data) ->
              if data.temperature
                $('.field-temperature').show() 
              else 
                $('.field-temperature').hide()
                
              if data.moisture
                $('.field-moisture').show() 
              else 
                $('.field-moisture').hide()
        
              if data.solids
                $('.field-solids').show() 
              else 
                $('.field-solids').hide()
                
              if data.bulk_density
                $('.field-bulk-density').show() 
              else 
                $('.field-bulk-density').hide()
                
              window_resize()
          )
        else 
          $('.field-lab-method').hide()

      $('#quality_lab_method_id').change()
      return
      
    new: ->
      Init.quality.edit()
      return
    
    create: ->
      Init.quality.edit()
      return
      
    update: ->
      Init.quality.edit()
      return
      
  lot:
    certificate: ->
      $('#certificate_part_number').mask('9999a')
      $('#certificate_part_number').on 'change', ->
        $(this).val $(this).val().toUpperCase()
      $('#certificate_lot').on 'change', ->
        $('.lot-items').hide()
        if $(this).val() != ''
          $.post('/lot/certificate.js', $('form').serialize(), (data) ->
            $('.lot-items').slideDown(100,window_resize)
            $('#toggle-button').show()
            $('#add-selected-button').show()
          ,'script')
          return false
        if $(this).val() == ''
          $('#toggle-button').hide()
          $('#add-selected-button').hide()
        else
          $('#toggle-button').show()
          $('#add-selected-button').show()
      $('.lot-items tr.clickable').live 'click', (evt) ->
        checked_val = $(this).find('input[type=checkbox]').attr('checked')
        if(checked_val == '' || checked_val == undefined)
          checked_val = 'checked'
        else 
          checked_val = null
        $(this).find('input[type=checkbox]').attr('checked',checked_val)
      $('#toggle-button').on 'click', (evt) ->
          checked_val = $('input[type=checkbox]').attr('checked')
          if(checked_val == '' || checked_val == undefined)
            checked_val = 'checked'
          else 
            checked_val = null
          $('input[type=checkbox]').attr('checked',checked_val)
          return false
      $('#add-selected-button').on 'click', (evt) ->
        $('input[type=checkbox]:checked').each ->
          if !Page.lot.certificate.records_already_added[$(this).val()]
            Page.lot.certificate.records_added.push($(this).val())
            Page.lot.certificate.records_already_added[$(this).val()] = true
        update_certificate_dashboard()
        $('#certificate_lot').selectmenu('value','')
        $('#certificate_lot').change()
        window_resize()
        return false
      $('#review-button').on 'click', ->
        form_data = $('form').serialize() + '&quality_to_include=' + Page.lot.certificate.records_added
        $.post('/lot/certificate_review', form_data, (data) ->
          $('.modal').html(data)
          $('.modal').show()
          $('.modal .dialog').hide().delay(100).css({top:'-520px'}).show().animate({top:'-1px'},200)
        )
        return false
      $('#done-button').live 'click', ->
        $('.modal .dialog').delay(100).animate({top:'-520px'},200, ->
          setTimeout -> 
            $('.modal .dialog').hide()
          , 200
          setTimeout -> 
            $('.modal').hide()
          , 400
          return
        )
        return false
      $('.back-link').live 'click', ->
        $('.modal .dialog').delay(100).animate({top:'-520px'},200, ->
          setTimeout -> 
            $('.modal .dialog').hide()
          , 200
          setTimeout -> 
            $('.modal').hide()
          , 400
          return
        )
        return false
      $('.remove-item-button').live 'click', ->
        item_id = $(this).attr('id').replace 'remove-item-button-', ''
        item_id_index = Page.lot.certificate.records_added.indexOf item_id
        item_added_id_index = Page.lot.certificate.records_already_added.indexOf item_id
        if item_id_index >= 0
          Page.lot.certificate.records_already_added[item_id] = false
          Page.lot.certificate.records_added.splice(item_id_index,1)
          $(this).parents('tr').find('td').fadeOut(200, ->
            $(this).parent('tr').remove()
          )
          update_certificate_dashboard()
        return false
      $('#generate-button').live 'click', ->
        form_data = $('form').serialize() + '&quality_to_include=' + Page.lot.certificate.records_added
        $.post('/lot/certificate_generate', form_data, (data) ->
          $('.modal').html(data)
          $('.modal').show()
          $('.modal .dialog').hide().delay(100).css({top:'-520px'}).show().animate({top:'-1px'},200)
        )
        return false
      $('#certificate_part_number').live 'change', -> 
        $(this).val($(this).val().toUpperCase())
      $('#print-button').live 'click', ->
        $(this).parents('form').submit()
        return

$ ->
  init()
  init_action()
  return

init = ->
  System.controller = $('#main').attr 'x-data-controller'
  System.action = $('#main').attr 'x-data-action'
  
  init_resize()
  init_nav()
  if_notice()
  if_alert()
  
  #  Select menus
  $('select').selectmenu {style:'dropdown'}
  #  Remote forms
  $('form[data-remote],a[data-remote],input[data-remote]').on 'ajax:complete', remote_form_post_load
  #  Pagination 
  $('.application #main .pagination span').live 'click', -> 
    $(this).find('a').click()
    evt.stopPropagation()
    return
  # Placeholder Support
  if !$('html').hasClass('placeholder')
    $('form').each (i,e) ->
      $(e).on 'submit', -> 
        $('input,textarea').each (i,e) ->
          if $(this).attr('placeholder') == $(this).val()
            $(this).val('')
    $('input,textarea').each (i,e) ->
      ph = $(e).attr('placeholder')
      if ph
        $(e).val(ph)
        $(e).on 'focus', (evt) ->
          if $(this).attr('placeholder') == $(this).val()
            $(this).val('')
        $(e).on 'blur', (evt) ->
          if $(this).val() == '' 
            $(this).val($(this).attr('placeholder'))
          
  init_result_tabs()
  init_event_tabs()
  init_main_page()
  init_action_boxes()
  init_result_rows()
  
  window_resize()
  
  return

init_action = ->
  action = 'Init.' + System.controller + '.' + System.action
  try
    eval(action)
    if typeof eval(action) == 'function'
      eval action + '();'
  
  return
  
init_nav = -> 
  $('.navigation ul li').on 'click', nav_item_click
  return

init_resize = ->
  $(window).on 'resize', window_resize
  return
  
init_result_tabs = ->
  $('.result-navigation ul li').on 'click', result_tab_item_click
  return
  
init_event_tabs = ->
  $('.event-navigation ul li').on 'click', event_tab_item_click
  return
  
init_main_page = -> 
  $('button,a.link-button,a.small-link-button,.actions-container .action,input[type=button],input[type=submit]').live 'mouseup', button_mouseup
  $('button,a.link-button,a.small-link-button,.actions-container .action,input[type=button],input[type=submit]').live 'mousedown', button_mousedown
  return

init_action_boxes = ->
  $('.actions-container .action .wrapper').on 'click', actions_container_click
  return

init_result_rows = ->
  $('tr').live 'click', result_row_click
  return

if_notice = ->
  if($('p.notice').text().length > 0)
    $('p.notice').slideDown(100)
  return
    
if_alert = -> 
  if($('p.alert').text().length > 0)
    $('p.alert').slideDown(100)
  return
  
update_certificate_dashboard = ->
  $('.message').hide()
  $('.dashboard').show()
  prev_records = $('.total-records .wrapper').text()
  increase_visual = setInterval ->
    if parseInt($('.total-records .wrapper').text()) != Page.lot.certificate.records_added.length
      if parseInt($('.total-records .wrapper').text()) < Page.lot.certificate.records_added.length
        new_val = parseInt($('.total-records .wrapper').text())
        new_val++
        $('.total-records .wrapper').html(new_val)
      else if parseInt($('.total-records .wrapper').text()) > Page.lot.certificate.records_added.length
        new_val = parseInt($('.total-records .wrapper').text())
        new_val--
        $('.total-records .wrapper').html(new_val)
    else
      clearInterval(increase_visual)
  , 10

result_tab_item_click = (evt) -> 
  $('.result-navigation ul li').removeClass('current')
  $(this).addClass('current')
  $('.result-content ul li').removeClass('current').css('display','none')
  $('.result-content ul li:nth-child(' + ($(this).index() + 1) + ')').addClass('current').css('display','block')
  return
  
nav_item_click = (evt) -> 
  document.location.href = $(this).find('a').attr('href')
  return
  
event_tab_item_click = (evt) -> 
  $('.event-navigation ul li').removeClass('current')
  $(this).addClass('current')
  $('.event-content ul li').removeClass('current').css('display','none')
  $('.event-content ul li:nth-child(' + ($(this).index() + 1) + ')').addClass('current').css('display','block')
  return

actions_container_click = (evt) ->
  document.location.href = $(this).find('a').attr('href')
  return
  
result_row_click = (evt) ->
  if $(this).not('th').find('a').size() == 1
    if $(this).not('th').find('a').attr('href').length > 0 && $(this).hasClass('clickable')
      document.location.href = $(this).find('a').attr('href')
      evt.stopPropagation()
  return

button_mouseup = (evt) ->
  $(this).css('top','1px')
  return
  
button_mousedown = (evt) ->
  $(this).css('top','3px')
  return
 
window_resize = (evt) ->
  $('.navigation').css('height',$('.content').height())
  return

remote_form_post_load = (evt) ->
  window_resize()
