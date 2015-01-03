Select 'grant exec on ' + name +  ' TO ' + ' Public ' 
from sys.procedures 
where [type] = 'P' and is_ms_shipped = 0 and [name] not like 'sp[_]%diagram%'

