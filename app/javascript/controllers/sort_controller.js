// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  static targets = ["ban"];

  connect() {
    this.sortable = Sortable.create(this.element, {
    onEnd: this.end.bind(this)
    })
  }

  end(event) {
    console.log(event)
    let id = event.item.dataset.id
    let tid = event.item.dataset.tid
    let tpid = event.item.dataset.tpid
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    Rails.ajax({
    url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace(":trip_participant_id", tpid),
    type: 'PUT',
    data: data
    })
  }

  updateVeto(event) {

    // event.currentTarget.innerHTML = "XXX"
    console.log("Clicked!")
    console.log(event.currentTarget)
    console.log(event.currentTarget.dataset.id)
    console.log(this.data.get("url"))
    event.currentTarget.classList.toggle('veto-off')
    event.currentTarget.classList.toggle('veto-on')

    let id = event.currentTarget.dataset.id
    let tid = event.currentTarget.dataset.tid
    let tpid = event.currentTarget.dataset.tpid
    let data = new FormData()
    data.append('sub_action', 'veto')

    Rails.ajax({
    url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace(":trip_participant_id", tpid),
    type: 'PUT',
    data: data
    })
  }
}
