@RecordForm = React.createClass
  getInitialState: ->
    title: ""
    date: ""
    amount: ""

  render: ->
    React.DOM.form
      className: "form-inline"
      onSubmit: @handleSubmit
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "text"
          className: "form-control"
          placeholder: "Date"
          name: "date"
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "text"
          className: "form-control"
          placeholder: "Title"
          name: "title"
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: "form-group"
        React.DOM.input
          type: "text"
          className: "form-control"
          placeholder: "Amount"
          name: "amount"
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        type: "submit"
        className: "btn btn-primary"
        disabled: !@valid()
        "Create Record"

  handleChange: (event) ->
    # This gets fired on every change to any input field; name is used to detect
    # which field was changed
    # @setState updates the component's @state and schedules a UI re-render
    name = event.target.name
    @setState "#{name}": event.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post "",
      record: @state,
      (record) =>
        @props.handleNewRecord record
        @setState @getInitialState()
      , "JSON"

  valid: ->
    # Submit button only active when all three fields are not empty
    @state.title && @state.date && @state.amount

