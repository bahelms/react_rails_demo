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
                React.DOM.th null,
                  React.DOM.div null,
                    "Title"
                    React.DOM.button
                      className: "btn btn-xs btn-default"
                      id: "sort_button"
                      onClick: @handleTitleSort
                      "Sort"
                React.DOM.th null, "Amount"
                React.DOM.th null, "Actions"
            React.DOM.tbody null,
              for record in @state.records
                # key is for proper re-rendering
                React.createElement Record,
                  key: record.id,
                  record: record,
                  handleDeleteRecord: @deleteRecord
                  handleEditRecord: @updateRecord

  # JSX syntax
  # render: ->
  #   `<div className="records">
  #     <h2 className="title">Records<h2>
  #   </div>`

  addRecord: (record) ->
    # Old update
    # records = @state.records.slice()
    # records.push(record)

    records = React.addons.update(@state.records, {$push: [record]})
    # setState sets for that specific key in the object
    @setState records: records

  deleteRecord: (record) ->
    # Old update
    # records = @state.records.slice()
    # records.splice(records.indexOf(record), 1)

    index = @state.records.indexOf(record)
    records = React.addons.update(@state.records, {$splice: [[index, 1]]})
    # replaceState totally overrides entire state and replaces with the object
    @replaceState records: records

  updateRecord: (oldRecord, newRecord) ->
    index = @state.records.indexOf(oldRecord)
    records = React.addons.update(@state.records, {$splice: [[index, 1, newRecord]]})
    @setState records: records

  handleTitleSort: (e) ->
    @state.records.sort (a, b) ->
      if a.title < b.title then return -1 else return 1
      return 0
    @setState records: @state.records

  credits: ->
    credits = @state.records.filter((val) -> val.amount >= 0)
    credits.reduce ((acc, record) -> acc + parseFloat(record.amount)), 0

  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((acc, record) -> acc + parseFloat(record.amount)), 0

  balance: -> @debits() + @credits()


