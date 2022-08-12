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
</script>


<div class="row">
  <div class="input-field col s6">
    <i class="material-icons prefix">edit</i>
    <input type="text" id="title" bind:value="{title}">
    <label for="title">Title</label>
  </div>

  <div class="input-field col s12">
    <textarea bind:value="{details}" id="details" class="materialize-textarea"></textarea>
    <label for="details">Details</label>
  </div>

  <div class="col s4">
    <button class="btn waves-effect waves-light" type="submit" on:click={createTodo}>
      <i class="material-icons right">send</i>
      Submit
    </button>
  </div>
</div>
