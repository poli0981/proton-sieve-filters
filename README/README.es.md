# Filtros Sieve para Proton

## Descripción
Este repositorio proporciona scripts Sieve listos para usar para usuarios de Proton Mail. Sieve es un lenguaje de dominio específico (DSL) para el filtrado de correos electrónicos en el lado del servidor, permitiendo acciones como mover correos, marcar como leídos o caducar. El filtro de redes sociales es el punto de partida, con extensiones para otras categorías.

**Nota sobre Dominios**: Las listas de dominios para diferentes filtros (por ejemplo, redes sociales, facturas) se almacenan en 'domains.txt'. Puedes editar este archivo para agregar o eliminar dominios sin modificar los scripts.

## Limitaciones
- Estos scripts están optimizados para Proton Mail y pueden requerir modificaciones para otros servicios de correo (ej., eliminar extensiones específicas de Proton como "vnd.proton.expire").
- Se recomienda conocimiento básico de programación en Sieve (o scripting similar) para personalización, ya que errores pueden llevar a correos perdidos o rechazados.
- Los filtros se aplican solo a correos entrantes; no reorganizan mensajes existentes.
- Riesgos potenciales: Reglas demasiado amplias podrían causar falsos positivos (ej., rechazar correos importantes); siempre prueba exhaustivamente.
- Sin garantía: Úsalo bajo tu propio riesgo, según estándares de código abierto.

## Uso
1. Inicia sesión en Proton Mail → Configuración → Filtros → Agregar Filtro Sieve.
2. Copia el script de un archivo .sieve (por ejemplo, filters/social_media.sieve) y pégalo.
3. Personaliza los dominios en 'domains.txt' si es necesario.
4. Prueba con correos de muestra.

**Filtros Disponibles**:
- Redes Sociales: Filtra notificaciones de X, Facebook, etc. (primer filtro en el repositorio).
- Facturas: Mueve correos de facturación de PayPal, Amazon, etc.
- Anuncios: Maneja correos promocionales.
- Más por venir...

## Contribución
Haz un fork del repositorio, agrega nuevos filtros o dominios, y envía una pull request. Sigue el Semantic Versioning para actualizaciones (por ejemplo, v0.1.0).

## Licencia
Licencia MIT - Libre para usar y modificar.