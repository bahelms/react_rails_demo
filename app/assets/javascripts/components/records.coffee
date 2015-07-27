@Records = React.createClass
  getInitialState: ->
    # sets @state attribute
    records: @props.data

  getDefaultProps: ->
    # sets default @props if no data was given to 'react_component'
    records: []

  # required; renders the component
  render: ->
    React.DOM.div
      className: "records"
      React.DOM.div
        className: "row"
        React.DOM.div
          className: "col-md-8 col-md-offset-2"
          React.DOM.h2
            className: "title"
            "Records"
      React.DOM.div
        className: "row"
        React.DOM.div
          className: "col-md-9 col-md-offset-2"
          React.createElement AmountBox,
            type: "success", text: "Credit", amount: @credits()
          React.createElement AmountBox,
            type: "danger", text: "Debit", amount: @debits()
          React.createElement AmountBox,
            type: "info", text: "Balance", amount: @balance()
      React.DOM.div
        className: "row"
        React.DOM.div
          className: "col-md-8 col-md-offset-2"
          React.createElement RecordForm, handleNewRecord: @addRecord
      React.DOM.div
        className: "row"
        React.DOM.div
          className: "col-md-7 col-md-offset-2"
          React.DOM.hr null
      React.DOM.div
        className: "row"
        React.DOM.div
          className: "col-md-7 col-md-offset-2"
          React.DOM.table
            className: "table table-bordered"
            React.DOM.thead null,
              React.DOM.tr null,
                React.DOM.th null, "Date"
                React.DOM.th null, "Title"
                React.DOM.th null, "Amount"
                React.DOM.th null, "Actions"
            React.DOM.tbody null,
              for record in @state.records
                # key is for proper re-rendering
                React.createElement Record,
                  key: record.id, record: record, handleDeleteRecord: @deleteRecord

  # JSX syntax
  # render: ->
  #   `<div className="records">
  #     <h2 className="title">Records<h2>
  #   </div>`

  addRecord: (record) ->
    records = @state.records.slice()
    records.push(record)
    # setState sets for that specific key in the object
    @setState records: records

  deleteRecord: (record) ->
    records = @state.records.slice()
    records.splice(records.indexOf(record), 1)
    # replaceState totally overrides entire state and replaces with the object
    @replaceState records: records

  credits: ->
    credits = @state.records.filter((val) -> val.amount >= 0)
    credits.reduce ((acc, record) -> acc + parseFloat(record.amount)), 0

  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((acc, record) -> acc + parseFloat(record.amount)), 0

  balance: -> @debits() + @credits()


