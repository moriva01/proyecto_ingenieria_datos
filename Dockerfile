# Dockerfile

# Usa una imagen base de Python
FROM python:3.10-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos del proyecto y de requisitos
COPY requirements.txt requirements.txt
COPY . .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto de Flask
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "run.py"]
