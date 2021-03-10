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

  // Rails.ajax({
  // url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace("trip_participant_id", tpid),
  // type: 'PATCH',
  // data: data
  // })
  }
}
