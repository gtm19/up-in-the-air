import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["foo"];

    connect(){
        console.log("I am connected!")
    }

    updateName(event) {
        this.fooTarget.innerHTML = "Saved"

        console.log("Clicked!")
    }

}
