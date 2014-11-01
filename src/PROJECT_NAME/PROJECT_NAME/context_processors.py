from django.conf import settings

def globals(request):
	return{
		'GLOBALS':{
			'BASE_URL': settings.BASE_URL
		}
	}

	

