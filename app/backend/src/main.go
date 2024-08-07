package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"sync"
)

type Book struct {
	Name string `json:"name"`
}

var cacheMutex sync.RWMutex

var bookCache = make(map[int]Book)

func main() {
	mux := http.NewServeMux()
	// root webpage
	mux.HandleFunc("/", handleRoot)
	// create book
	mux.HandleFunc("POST /books", createBook)
	mux.HandleFunc("GET /books/{id}", getBook)
	mux.HandleFunc("DELETE /books/{id}", deleteBook)

	fmt.Println("Server listening now...")
	http.ListenAndServe(":8080", mux)
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, there... Not quite ready, yet.")
}

func createBook(w http.ResponseWriter, r *http.Request) {
	var book Book
	// expecting a simple json with "name" key for the book and the corresponding val
	err := json.NewDecoder(r.Body).Decode(&book)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if book.Name == "" {
		http.Error(w, "No book name specified", http.StatusBadRequest)
		return
	}

	// lock our cache
	cacheMutex.Lock()
	bookCache[len(bookCache)+1] = book
	cacheMutex.Unlock()

	w.WriteHeader(http.StatusNoContent)
}

func getBook(w http.ResponseWriter, r *http.Request) {
	path_id, err := strconv.Atoi(r.PathValue("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// lock reading
	cacheMutex.RLock()
	book, ok := bookCache[path_id]
	cacheMutex.RUnlock()

	if !ok {
		http.Error(w, "Book not found!", http.StatusNotFound)
	}

	w.Header().Set("Content-Type", "application/json")
	// json response
	j, err := json.Marshal(book)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// 200
	w.WriteHeader(http.StatusOK)
	// write our marshaled byte slice
	w.Write(j)
}

func deleteBook(w http.ResponseWriter, r *http.Request) {
	path_id, err := strconv.Atoi(r.PathValue("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if _, ok := bookCache[path_id]; !ok {
		http.Error(w, "Book not found!", http.StatusBadRequest)
		return
	}

	cacheMutex.Lock()
	delete(bookCache, path_id)
	cacheMutex.Unlock()

	w.WriteHeader(http.StatusNoContent)
}
