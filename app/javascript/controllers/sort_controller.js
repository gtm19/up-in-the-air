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
    this.banTarget.innerHTML = "Veto'd"
    console.log("Clicked!")
    console.log(event)
    console.log(event.path[0].dataset.id)
    console.log(this.data.get("url"))

    let id = event.path[0].dataset.id
    let tid = event.path[0].dataset.tid
    let tpid = event.path[0].dataset.tpid
    let data = new FormData()
    data.append('sub_action', 'veto')

    Rails.ajax({
    url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace(":trip_participant_id", tpid),
    type: 'PUT',
    data: data
    })
  }
}
