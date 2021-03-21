import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["savePref"];

    connect(){
        console.log("I am connected!")
    }

    savePref(event) {

    let id = event.currentTarget.dataset.id
    let tid = event.currentTarget.dataset.tid
    let tpid = event.currentTarget.dataset.tpid
    let time  = document.getElementById('time').value
    let budget  = document.getElementById('budget').value
    let out_date  = document.getElementById('out_date').value
    let in_date  = document.getElementById('in_date').value
    let data = new FormData()
    data.append('sub_action', 'pref_click')
    data.append('time_preference', time)
    data.append('budget_preference', budget)
    data.append('out_date', out_date)
    data.append('in_date', in_date)
    console.log(data)
    console.log(time)
    console.log(budget)

    Rails.ajax({
        url: this.data.get("url").replace(":trip_id", tid).replace(":id", tpid),
        type: 'PATCH',
        dataType: 'json',
        data: data
      })
  }
}

