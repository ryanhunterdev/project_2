const deleteBtn = document.querySelector(".delete-btn")
const deleteModal = document.querySelector(".delete-modal")
const closeDeleteModal = document.querySelector(".close-delete-modal")


function revealModal() {
    deleteModal.classList.add("reveal-modal");
}

function closeModal() {
    deleteModal.classList.remove("reveal-modal");
}


deleteBtn.addEventListener("click", revealModal);
closeDeleteModal.addEventListener("click", closeModal);

