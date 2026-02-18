select
*
from {{ source('DEMO', 'BIKE') }}

LIMIT 10