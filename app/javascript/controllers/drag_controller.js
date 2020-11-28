// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import Rails from "@rails/ujs"
Rails.start()
import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element,{
      onEnd: this.end.bind(this)
    })
  }
  end(event){
    let row = document.querySelector(".row")
    let post_id = row.id
    let id = event.item.dataset.id
    let url = "/posts/:post_id/elements/:id/move".replace(":post_id", post_id)
    let data = new FormData()
    data.append("position", event.newIndex +1)

    Rails.ajax({
      url: url.replace(":id", id),
      type: "patch",
      data: data
    })
  }
}
