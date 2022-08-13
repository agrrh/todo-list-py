<script>
  import Form from './lib/Form.svelte'
  import List from './lib/List.svelte'
</script>

<main>
  <h1 class="header">
    Todo List Python

    <button class="btn-floating btn-large modal-trigger waves-effect waves-light" data-target="modal-form">
      <i class="material-icons">add</i>
    </button>
  </h1>

  <div class="section">
    <Form />
  </div>

  <div class="divider"></div>

  <div class="section">
    <List />
  </div>
</main>
