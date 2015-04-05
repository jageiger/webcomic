ready = ->

  $ ->
    # Configure infinite table
    $('.infinite-table').infinitePages
      debug: true
      loading: ->
        $(this).text('Loading next page...')
      error: ->
        $(this).button('There was an error, please try again')

$(document).ready(ready)
$(document).on('page:load', ready)

