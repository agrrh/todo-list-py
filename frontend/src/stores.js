import { writable } from 'svelte/store'

export const todosRefreshTime = writable(0)
export const todos = writable([])
