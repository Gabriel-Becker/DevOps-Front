import React, { useState } from 'react';
import './Message.css';

function Message() {
    const [message, setMessage] = useState('');
    const [echoMessage, setEchoMessage] = useState('');

    const handleInputChange = (event) => {
        setMessage(event.target.value);
    };


    // https://devops-back-txi2.onrender.com
    const fetchHello = async () => {
        try {
            const response = await fetch('https://devops-back-txi2.onrender.com/hello/hello');
            const data = await response.text();
            setEchoMessage(data);
        } catch (error) {
            console.error('Erro ao buscar mensagem:', error);
            setEchoMessage('Erro ao buscar mensagem.');
        }
    };

    const sendEcho = async () => {
        try {
            const response = await fetch('https://devops-back-txi2.onrender.com/hello/echo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ mensagem: message }),
            });
            const data = await response.text();
            setEchoMessage(data);
        } catch (error) {
            console.error('Erro ao enviar mensagem:', error);
            setEchoMessage('Erro ao enviar mensagem.');
        }
    };

    return (
        <div className="message-container">
            <h1>Componente Message</h1>
            <button onClick={fetchHello}>GET /hello</button>
            <br />
            <input
                type="text"
                value={message}
                onChange={handleInputChange}
                placeholder="Digite uma mensagem"
            />
            <button onClick={sendEcho}>POST /echo</button>
            <br />
            <p>Resposta da API: {echoMessage}</p>
        </div>
    );
}

export default Message;