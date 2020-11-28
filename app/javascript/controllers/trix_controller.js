import { Controller } from "stimulus"
import "trix"
import "@rails/actiontext"
export default class extends Controller {

    connect() {
    document.addEventListener('dblclick', () => {
        let element = event.target.closest('.paragraph-content')
        if (!element) return;

        element.classList.add('d-none')
        element.nextElementSibling.classList.remove('d-none')
    })

    document.addEventListener('dblclick', () => {

        let element = event.target.closest('.paragraph-form')

        element.classList.add('d-none')
        element.previousElementSibling.classList.remove('d-none')
  })
    }
}
