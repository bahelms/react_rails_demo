@Record = React.createClass
  render: ->
    # nulls mean the method is not getting attributes {}
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null,
        React.DOM.a
          className: "btn btn-xs btn-danger"
          onClick: @handleDelete
          "Delete"

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: "DELETE"
      url: "/records/#{@props.record.id}"
      dataType: "JSON"
      success: =>
        @props.handleDeleteRecord @props.record

