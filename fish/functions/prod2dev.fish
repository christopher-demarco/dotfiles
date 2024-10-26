function prod2dev --wraps=cd\ \(pwd\ \|\ sed\ \'s/q/q-dev/\'\) --description alias\ prod2dev=cd\ \(pwd\ \|\ sed\ \'s/q/q-dev/\'\)
  cd (pwd | sed 's/q/q-dev/') $argv
        
end
