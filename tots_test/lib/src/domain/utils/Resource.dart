abstract class Resource<T> {}

// Estados inicial y de carga sin datos específicos
class Initial<T> extends Resource<T> {}

class Loading<T> extends Resource<T> {}

// Respuesta exitosa con datos
class Success<T> extends Resource<T> {
  final T data;
  Success(this.data);
}

// Respuesta con mensaje de error
class Error<T> extends Resource<T> {
  final String message;
  Error(this.message);
}
