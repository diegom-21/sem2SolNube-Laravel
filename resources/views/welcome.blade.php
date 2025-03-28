<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diego - Tetracampeón</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }
        h1 {
            font-size: 3rem;
            color: #333;
        }
        img {
            width: 300px; 
            height: auto;
            margin-top: 20px;
            border-radius: 10px;
        }
        p {
            font-size: 1.5rem;
            color: #555;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <h1>Laravel en Render - Diego Moreno Nanfuñay</h1>
    
    <img src="{{ asset('images/alianzalogo.png') }}">
    
    <p>El único tetracampeón del fútbol peruano</p>

</body>
</html>
