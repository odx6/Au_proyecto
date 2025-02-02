<script setup>
import Checkbox from "@/Components/Checkbox.vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Modal from "@/Components/Modal.vue";
import TextInput from "@/Components/TextInput.vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import { computed, onMounted, onUnmounted, ref, watch } from "vue";

defineProps({
  images: {
    type: Array, // Definir que es un array
    required: true, // Si no es obligatorio
  },
});
const isModalVisible = ref(false);

const openModal = () => {
  isModalVisible.value = true;
};

const closeModal = () => {
  isModalVisible.value = false;
};
const form = useForm({
  id: null,
  name: "",
  image: null,
});

const submit = () => {
  form.post(route("images.store"), {
    preserveScroll: true,
    onSuccess: () => {
      closeModal(); // Cerrar el modal tras el éxito
      form.reset(); // Resetear el formulario
    },
  });
};
//
const onFileChange = (event) => {
  const file = event.target.files[0];

  // Validar si el archivo es una imagen
  const validImageTypes = ["image/jpeg", "image/png", "image/gif"]; // Tipos válidos
  if (file && validImageTypes.includes(file.type)) {
    form.image = file; // Asignar la imagen al formulario si es válida
  } else {
    // Mostrar un mensaje de error si no es una imagen
    alert("Por favor, seleccione un archivo de imagen válido (JPG, PNG, GIF).");
    form.image = null; // Limpiar el campo de la imagen
  }
};
const deleteImage = (id) => {
  form.id = id;
  if (confirm("¿Estás seguro de que deseas eliminar esta imagen?")) {
    form.delete(route("images.destroy", id), {
      preserveScroll: true,
      onSuccess: () => {
        alert("Imagen eliminada correctamente.");
      },
      onError: (errors) => {
        console.error(errors);
        alert("Hubo un error al eliminar la imagen.");
      },
    });
  }
};
</script>

<template>
  <AuthenticatedLayout>
    <template #header>
      <h2 class="text-xl font-semibold leading-tight text-gray-800">
        Lista de imagenes
        <PrimaryButton class="ms-4" @click="openModal">
          Agregar Imagen
        </PrimaryButton>
      </h2>
    </template>

    <div class="py-12">
      <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div class="mt-6 flex items-center justify-left">
          <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
            <div class="gallery">
              <div v-for="image in images" :key="image.id" class="image-item">
                <img
                  :src="`/storage/${image.path}`"
                  :alt="image.name"
                  class="image-thumbnail"
                />
                <h1>{{ image.name }}</h1>
                <button class="BotonDelete" @click="deleteImage(image.id)">
                  Eliminar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
 
    <Modal
      :show="isModalVisible"
      :maxWidth="'2xl'"
      :closeable="true"
      @close="closeModal"
    >
      <form @submit.prevent="submit">
        <div class="p-6">
          <div class="p-6">
            <InputLabel for="name" value="Name" />

            <TextInput
              id="name"
              type="text"
              class="mt-1 block w-full"
              v-model="form.name"
              required
              autofocus
              autocomplete="name"
            />

            <InputError class="mt-2" :message="form.errors.name" />
          </div>

          <div class="mt-6">
            <InputLabel for="image" value="image" />

            <TextInput
              id="image"
              type="file"
              class="mt-1 block w-full"
              v-model="form.image"
              required
              autocomplete="image"
              @change="onFileChange"
            />

            <InputError class="mt-2" :message="form.errors.image" />
          </div>

          <div class="mt-6 flex items-center justify-end">
            <PrimaryButton
              class="ms-4"
              :class="{ 'opacity-25': form.processing }"
              :disabled="form.processing"
            >
              agregar
            </PrimaryButton>
          </div>
        </div>
      </form>
    </Modal>
    </div>

  </AuthenticatedLayout>
</template>
<style scoped>
.gallery {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}
.image-item {
  text-align: center;
  position: relative;
}
.image-thumbnail {
  width: 150px;
  height: 150px;
  object-fit: cover;
}
.BotonDelete {
  position: absolute;
  top: 5px;
  right: 5px;
  background-color: red;
  color: white;
  border: none;
  padding: 5px;
  cursor: pointer;
}
.BotonDelete:hover {
  background-color: darkred;
}
</style>