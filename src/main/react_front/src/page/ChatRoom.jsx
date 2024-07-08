import React ,{useState, useEffect}from "react";
import firebase from 'firebase/compat/app';
import 'firebase/compat/database';

const ChatRoom=({ roomId, loggedInUser, toggleChatRoom })=>{
    const [messages, setMessages] = useState([]);
    const [newMessage, setNewMessage] = useState('');
    useEffect(() => {
        const chatRoomRef = firebase.database().ref(`chatRooms/${roomId}/messages`);

        // Fetch initial messages and set up real-time listener
        chatRoomRef.on('value', (snapshot) => {
            const data = snapshot.val();
            const messageArray = data ? Object.values(data) : [];
            setMessages(messageArray);
        });

        // Cleanup function to remove the listener
        return () => {
            chatRoomRef.off();
        };
    }, [roomId]);

    const sendMessage = async () => {
        if (newMessage.trim() !== '') {
            try {
                const messageRef = firebase.database().ref(`chatRooms/${roomId}/messages`);

                const currentDate = new Date();
                const hours = currentDate.getHours();
                const minutes = currentDate.getMinutes();
                const ampm = hours >= 12 ? 'pm' : 'am';
                const timestamp = `${currentDate.getFullYear()}-${('0' + (currentDate.getMonth() + 1)).slice(-2)}-${('0' + currentDate.getDate()).slice(-2)} ${hours % 12}:${minutes < 10 ? '0' + minutes : minutes}${ampm}`;

                const newMessageData = {
                    sender: loggedInUser,
                    content: newMessage,
                    timestamp: timestamp,
                };
                await messageRef.push(newMessageData);

                // Clear the input field after sending the message
                setNewMessage('');

            } catch (error) {
                console.error('Error sending message:', error);
            }
        }
    };


    useEffect(() => {
        const chatBody = document.querySelector('.chatbody');
        if (chatBody) {
            // 스크롤을 맨 아래로 이동
            chatBody.scrollTop = chatBody.scrollHeight;
        }
    }, [messages]);


    return(
        /*채팅방 큰 프레임*/
        <div style={{
            width: '400px',
            height: '590px',
            margin: 'auto',
            border: '1px solid #ccc',
            boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
            borderRadius: '8px'


        }}>
            {/*채팅방 헤더*/}
            <div style={{
                height: '40px',
                fontSize: '25px',
                backgroundColor: '#ff9595',
                color: 'white',
                padding: '10px',
                textAlign: 'left'
            }}>
                Chat_room: {roomId}
                <button style={{
                    float: 'right',
                    border: 'none',
                    padding: '8px',
                    backgroundColor: '#eee',
                    borderRadius: '4px',
                    cursor: 'pointer'
                }} onClick={toggleChatRoom}>닫기
                </button>
            </div>


            {/*채팅방 바디*/}
            <style>{` .chatbody::-webkit-scrollbar{display: none;} `}</style>

            <div style={{
                height: '500px',
                padding: '10px',
                background: 'rgba(256,256,256,0.8)'
            }}>
                <ul className={"chatbody"}
                    style={{
                        padding: 0,
                        margin: 0,
                        listStyle: 'none',
                        maxHeight: '100%', // 부모 컨테이너에 맞게 높이 설정
                        overflowY: 'auto' // 내용이 넘칠 때만 스크롤 표시
                    }}
                >
                    {messages.map((message, index) => (
                        <li key={index} style={{
                            textAlign: message.sender === loggedInUser ? 'right' : 'left'
                        }}>
                            <p style={{
                                backgroundColor: message.sender === loggedInUser ? '#ff9595' : '#eee',
                                padding: '8px',
                                borderRadius: '8px',
                                display: 'inline-block',
                                margin: '5px 0'
                            }}>{message.sender}: {message.content}</p>
                            <div>{message.timestamp}</div>
                        </li>
                    ))}
                </ul>
            </div>


            {/*채팅방 푸터 입력창*/}
            <div style={{
                height: '50px',
                padding: '10px',
                borderTop: '1px solid #ccc',
                background: '#ccc'
            }}>
                <input
                    type="text"
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    placeholder="메시지 입력"
                    style={{
                        fontSize: '15px',
                        width: '70%',
                        padding: '8px',
                        marginRight: '20px',
                        border: '1px solid #ccc',
                        borderRadius: '4px'
                    }}
                />
                <button onClick={sendMessage}
                        style={{
                            padding: '8px',
                            backgroundColor: '#ff9595',
                            color: 'white',
                            border: 'none',
                            borderRadius: '4px',
                            cursor: 'pointer'
                        }}
                >전송
                </button>
            </div>


        </div>
    )

}
export default ChatRoom;