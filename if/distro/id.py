try:
	import distro;
	print(distro.id());
except ImportError:
	import platform;
	print(platform.linux_distribution()[0].lower());
