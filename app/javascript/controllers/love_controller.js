import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["love"];

    connect(){
        console.log("I am connected!")
    }

    updateLove(event) {
    // this.loveTarget.innerHTML = "Saved"


    let id = event.currentTarget.dataset.id
    let tid = event.currentTarget.dataset.tid
    let pdid = event.currentTarget.dataset.pdid
    let tpid = event.currentTarget.dataset.tpid
    let data = new FormData()
    data.append('sub_action', 'icon_click')
    data.append('est', id)

    if (event.currentTarget.classList.contains('love-off')) {
      event.currentTarget.classList.toggle('love-off')
      event.currentTarget.classList.toggle('love-on')
      console.log("Love Add")
      console.log(this.data.get("curl"))
      Rails.ajax({
        url: this.data.get("curl").replace(":trip_id", tid).replace(":trip_participant_id", tpid),
        type: 'POST',
        dataType: 'json',
        data: data,
        success: function(response) {
        const element = document.getElementById(response.est)
        element.dataset.pdid = response.pd;
        }
      })

    } else {
      event.currentTarget.classList.toggle('love-off')
      event.currentTarget.classList.toggle('love-on')
      console.log("Love Gone")
      console.log(this.data.get("durl"))
      console.log(tpid)
      Rails.ajax({
      url: this.data.get("durl").replace(":trip_id", tid).replace(":trip_participant_id", tpid).replace(":id", pdid),
      type: 'DELETE',
      data: data
      })

    }
  }
}
