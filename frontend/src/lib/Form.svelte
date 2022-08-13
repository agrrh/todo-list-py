<script>
  import { createEventDispatcher } from 'svelte';
  import { todosRefreshTime } from '../stores.js'

  let title = ''
  let details = ''
  let result = null

  async function createTodo () {
    const res = await fetch(`http://localhost:8081/todo`, {
      method: 'POST',
      body: JSON.stringify({
        title,
        details,
      }),
      headers: {
        "content-type": "application/json"
      }
    })

    const json = await res.json()
    result = JSON.stringify(json)

    todosRefreshTime.set(Date.now());
  }

  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.modal')
    var instances = M.Modal.init(elems)
  });
</script>


<div id="modal-form" class="modal">
  <div class="modal-content input-field">
    <input type="text" id="title" bind:value="{title}">
    <label for="title">Title</label>
  </div>

  <div class="modal-content input-field">
    <textarea bind:value="{details}" id="details" class="materialize-textarea"></textarea>
    <label for="details">Details</label>
  </div>

  <div class="modal-footer">
    <button class="btn waves-effect waves-light modal-close" type="submit" on:click={createTodo}>
      <i class="material-icons right">send</i>
      Submit
    </button>
  </div>
</div>

<style>
  .modal {
    padding: 2em;
  }
</style>
