for i in {1..35}; do
   kubectl exec --namespace=default pod-curl -- sh -c 'test=`wget -qO- -T 2  http://svc-app-webcolor-recreate.default.svc.cluster.local:9000/info 2>&1` && echo "$test OK" || echo "Failed"';
   echo ""
done

