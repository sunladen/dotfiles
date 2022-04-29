compareInstalled() {

	latest_version="${1}"
	cmd="${2}"
  cmd_read_version="${3}"
	cmp=0
	
	if command -v "${cmd}" &> /dev/null; then
		installed_version="$(eval ${cmd} ${cmd_read_version})"
		if [ "${installed_version}" != "${latest_version}" ]; then
			echo "installed version ${installed_version}, newer version ${latest_version} available"
			cmp=1
		else
			echo "installed version ${installed_version} is up-to-date"
		fi
	else
		cmp=1
	fi
	
	if [ "${cmp}" -eq "1" ]; then
		read -r -p "install $latest_version? [Yn] " response
		case "$response" in
			[Yy])
				;;
			*)
				exit
				;;
		esac
	else
		exit 0
	fi

}



dependancies() {

  required=("${@}")
  missing=()

  for package in "${required[@]}"; do
		checking="checking for ${package}... "
		if dpkg-query -l "$package" &> /dev/null; then
			checking="${checking}yes"
		else
				checking="${checking}no"
			missing+=("${package}")
		fi
		echo ${checking}
  done

  if [ ${#missing[@]} -gt 0 ]; then
		echo "installing ${#missing[@]} packages..."
  fi

  for package in "${missing[@]}"; do
		sudo apt --yes install "${package}"
  done

}


downloadAndInstall() {

	tarball_url="${1}"
	filename="download.tar.gz"
			
	cd /tmp
	
	wget -O "${filename}" "${tarball_url}"
	extracted_dir=$(tar xvf "${filename}" | head -1)
	tar xvf "${filename}"

	cd "${extracted_dir}"
	./configure
	make
	sudo make install
	
	
	# Clean up
	cd ..
	rm -rf "${extracted_dir}"
	rm -f "${filename}"

}

