import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  connect() {
    console.log("Stimulus is working!")
  }

  handleClick(event) {
    event.preventDefault()
    Swal.fire({
      title: "Creating your recipes...",
      html: "Wait a few seconds",

      didOpen: () => {
        Swal.showLoading();
      },
    })
    window.location.href = event.target.href
  }
}
