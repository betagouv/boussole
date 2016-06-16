$ ->
  $('select[rel="autocomplete"]').each ->
    option = []
    $(this).find('option').each ->
      option.push $(this).text()

    input = $('<input>')
    input.attr('type','text')
    input.attr('name', $(this).attr('name') )
    input.attr('id', $(this).attr('id') )
    input.attr('class', $(this).attr('class') )
    input.attr('data-provide', 'typeahead' )
    input.val($(this).attr('data_default'))
    $(this).replaceWith(input)

    $(input).typeahead(source: option)
