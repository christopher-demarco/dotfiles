function dev2prod --wraps=cd\ \(pwd\ \|\ sed\ \'s/q-dev/q\'\) --wraps=cd\ \(pwd\ \|\ sed\ \'s/q-dev/q/\'\) --description alias\ dev2prod=cd\ \(pwd\ \|\ sed\ \'s/q-dev/q/\'\)
  cd (pwd | sed 's/q-dev/q/') $argv
        
end
