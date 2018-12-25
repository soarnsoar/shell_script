#####Set User's email address#####                                                                                                             
echo -e "type your email address: \c "
read address1
echo -e "Retype your email address: \c "
read address2

if [ "$address1" = "$address2" ]; then
    echo "your email address = $address1"
else
    echo "The addresses are NOT matched. Please try again."
    return 0
fi
export SKFlatLogEmail="$address1"
#################################### 
