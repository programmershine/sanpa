import React, {useEffect, useRef, useState} from 'react';
import firebase from 'firebase/compat/app';
import 'firebase/compat/database';
import axios from "axios";
import ChatRoom from "./ChatRoom";

//파이어베이스 사용 시 필요한 코드
const firebaseConfig = {
    apiKey: "AIzaSyB18vZPqKnceElo5oIftGaU45xRaoho8Uw",
    authDomain: "sanpa-c6a82.firebaseapp.com",
    databaseURL: "https://sanpa-c6a82-default-rtdb.firebaseio.com",
    projectId: "sanpa-c6a82",
    storageBucket: "sanpa-c6a82.appspot.com",
    messagingSenderId: "495243475176",
    appId: "1:495243475176:web:8eb86c02b740e0b50b315d",
    measurementId: "G-NV822LHWG3"
};

//파이어베이스 앱 초기화 (사전준비)
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}

//랜덤한 6자리 컬러 반환 메서드
const generateRandomColor = () => {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
};



//메인 메서드
const MothersLocation = ({ loggedInUserProps }) => {

    const [clickedMotherId, setClickedMotherId] = useState(/*()=>{
        return getMotherId();}*/null
    );

    const [loggedInUser, setLoggedinUser] = useState(null);
    const [selectedMother_Id, setSelectedMother_Id] =useState(null);
    const [selectedGoStop, setSelectedGoStop] = useState(0);

    //useState, useRef 모음
    //firebase에서 가져온 내 위치
    const [userLocation, setUserLocation] = useState({ latitude: null, longitude: null });
    //geolocation api에서 가져온 내 위치
    const [myLocation, setMyLocation] = useState({ latitude: null, longitude: null });
    const [data, setData] = useState([]);
    const [data2, setData2] = useState([]);
    const [data3, setData3] = useState(null);
    const [userCoordinates, setUserCoordinates] = useState([]);
    const [myCoordinates,setMyCoordinates] = useState([]);
    const [map, setMap] = useState(null); // 지도 객체 상태 추가
    const markerRefs = useRef({});
    const [showChat, setShowChat] = useState(false); // ChatRoom 표시 여부 상태 추가

    const [clickshowinfo, setClickshowinfo] = useState(false);
    const [clickedElementId,setClickedElementId] = useState("");
    const [clickedElementColor, setClickedElementColor] = useState("");
    const [clickedElementRelation, setClickedElementRelation] = useState("");
    const [clickedElementLocationAllowMth, setClickedElementLocationAllowMth] = useState(false);
    const [clickedElementName, setClickedElementName] = useState("");
    const [clickedElementTel, setClickedElementTel] = useState("");

    const [mapMaker, setMapMaker] = useState(0);



    useEffect(() => {
        setLoggedinUser(loggedInUserProps);
        if(!selectedMother_Id) {
            const motherId = sessionStorage.getItem("mother_id");
            setClickedMotherId(motherId);
        }else{
            setClickedMotherId(selectedMother_Id);
        }
    },[loggedInUserProps,selectedMother_Id]);


    useEffect(() => {
        if(!selectedMother_Id){
            setClickedMotherId(selectedMother_Id);
            console.log("clickedMotherId도 selectedMother과 동일하게 변경");
        }
    },[selectedMother_Id]);

    useEffect(() => {
        console.log(loggedInUser+'이게없누');
        console.log(clickedMotherId+'이게없누'+loggedInUser);
        const fetchData = async () => {
            // 커넥션테이블에서 "마더"가 가진 "헬퍼리스트"를 가져옴
            const connmotherid = { mother_id: clickedMotherId };
            const response1 = await axios.post('/api/data/connectionListUnion', connmotherid);
            console.log("들어갔다 1번");
            setData(response1.data);

        };
        const fetchData2 = async () => {

            // 커넥션테이블에서 "헬퍼"가 가진 "마더리스트"를 가져옴
            const helper_id = { helper_id: loggedInUser };
            const response2 = await axios.post('/api/data/connection_getMotherListNameUnion', helper_id);
            console.log("들어갔다 2번");
            setData2(response2.data);

            // "헬퍼"의 정보를 가져옴
            const response3 = await axios.post('/api/data/getHelper', helper_id);
            console.log("들어갔다 3번");
            setData3(response3.data);
        };
        if(clickedMotherId) {
            fetchData();
        }else{
            console.error('아직 clickedMotherId 데이터가 들어있지 않습니다.');
        }
        if(loggedInUser) {
            fetchData2();
        }else{
            console.error('아직 loggedInUser 데이터가 들어있지 않습니다.');
        }
    }, [loggedInUser,clickedMotherId,selectedMother_Id,map]);


    useEffect(() => {// watchPosition 메서드를 호출하고 watch ID를 변수에 저장

        const watchId = navigator.geolocation.watchPosition(
            (position) => {
                const { latitude, longitude } = position.coords;// 위치 정보를 상태에 설정
                setMyLocation({ latitude, longitude });// 위치 정보를 파이어베이스에 업데이트하는 등의 작업을 수행할 수 있음
                setMapMaker(latitude);
            },
            (error) => {
                alert("위치권한이 허용되어있지 않습니다.\n사용자의 실시간 위치를 불러올 수 없습니다.\n브라우저의 위치 권한을 허용하고 새로고침 해주세요.");
                //서울시청좌표
                const latitude = 37.5642135;
                const longitude = 127.0016985;
                const newMap = new window.naver.maps.Map('map', {
                    center: new window.naver.maps.LatLng(latitude, longitude),
                    zoom: 14
                });
                setMap(newMap);
                console.error("위치를 불러올 수 없어 지도 초기 위치를 '서울시청'으로 설정합니다. 위치권한을 허용하세요.", error);// 오류 처리
            }
        );
        return () => { // 컴포넌트가 언마운트될 때 watchPosition을 중지함
            navigator.geolocation.clearWatch(watchId);
        };
    }, [selectedGoStop,selectedMother_Id]); // 빈 배열을 전달하여 이 useEffect는 한 번만 실행됨

    useEffect(() => { //파이어베이스에 경로생성

        if (loggedInUser) {
            const locationRef = firebase.database().ref(`userLocations/${loggedInUser}`);
            if(loggedInUser){
                console.log("넘어오냐구우" + loggedInUser);
                console.log("1" + locationRef.name);
                locationRef.once('value', (snapshot) => {
                    console.log("2");
                    const fireInfo = snapshot.val();
                    if(!fireInfo){
                        console.log("3");
                        //파이어베이스에 값이없으면 새로만듬.
                        const color = generateRandomColor();
                        const latitude = 0;
                        const longitude = 0;
                        locationRef.set({color, latitude, longitude})

                    }
                });
            }
        }
    },[loggedInUser,data3]);

    useEffect(() => {
        if (data3 !== null) {
            console.log("이게돌긴하니?");
            // 파이어베이스 경로 저장
            const locationRef = firebase.database().ref(`userLocations/${loggedInUser}`);
            const locationRef2 = firebase.database().ref(`userLocations/${clickedMotherId}/nicknrel`);

            locationRef.once('value', (snapshot) => {
                const fireInfo = snapshot.val();
                // 파이어베이스에 값이 있으면 업데이트함.
                if (fireInfo) {
                    console.log("업데이트가 되나요?");

                    // 이름과 전화번호 업데이트
                    const name = data3.helper_name;
                    const tel = data3.helper_tel;
                    locationRef.update({ name, tel });

                    // 위치 업데이트
                    const latitude = myLocation.latitude;
                    const longitude = myLocation.longitude;
                    locationRef.update({ latitude, longitude });

                    console.log(fireInfo.latitude +","+ fireInfo.longitude + "이것과" + myLocation.latitude+","+myLocation.longitude + data3.helper_name);
                    if(data2 !== null){
                        data.forEach((helper) => {
                            console.log("222");

                            try {
                                const helperId = helper.helper_id ?? null;
                                const nickname = helper.nicknameOfHelper ?? '미설정';
                                const relation = helper.relation !== null ? helper.relation : '미설정';
                                const locationallowmth = helper.locationallowmth == 0 ? 0: helper.locationallowmth == 1 ? 1: '미설정';

                                locationRef2.child(helperId).update({ nickname, relation, locationallowmth });
                            } catch (error) {
                                console.error('등록한 헬퍼가 없어서 파이어베이스에 업데이트할 수 없습니다.:', error);
                            }
                        });
                    }
                } else {
                    console.error('파이어베이스에 등록되지 않은 회원입니다. 오류를 수정해주세요.:');
                }
            });

            return () => {
                locationRef.off();
            };
        }
    }, [data3,data2, myLocation]);



    // 사용자 위치 정보 가져오기 (사용자 것만 조회해서)
    useEffect(() => {
        if(clickedMotherId) {
            console.log(loggedInUser + "여기나오냐고오오아이디가 ");
            const locationRef = firebase.database().ref(`userLocations/${clickedMotherId}`);
            locationRef.on('value', (snapshot) => {
                const {latitude, longitude, color, tel, name, nicknrel} = snapshot.val();
                const mycoordinates = {latitude, longitude, color, tel, name, nicknrel}
                setMyCoordinates(mycoordinates || {
                    latitude: null,
                    longitude: null,
                    color: null,
                    tel: null,
                    name: null,
                    nicknrel: null,
                });
            });
            return () => {
                locationRef.off();
            };
        }
    }, [loggedInUser]);


    // 모든 사용자의 좌표 정보 배열로 가져오기
    useEffect(() => {
        if(loggedInUser){
            const userCoordsRef = firebase.database().ref(`userLocations`);
            userCoordsRef.on('value', (snapshot) => {
                const coordinates = snapshot.val();
                setUserCoordinates(Object.entries(coordinates || {}).map(([key, value]) => ({ user: key, ...value })));
                console.log(coordinates.mother3.name +"모든사용자 정보가져옴 mother1 이름");
            });

            return () => {
                userCoordsRef.off();
            };
        }
    }, [loggedInUser]);

    useEffect(() => {
        if(mapMaker !== 0) {
            if (myLocation.latitude !== null && myLocation.longitude !== null) {
                console.log("처음에 지도만들어?");
                // 기존 지도 객체가 있는지 확인하고 없으면 생성
                if (!map) {
                    console.log(myLocation.latitude + "," + myLocation.longitude + "이게좌표일세");
                    const latitude = myLocation.latitude;
                    const longitude = myLocation.longitude;
                    const newMap = new window.naver.maps.Map('map', {
                        center: new window.naver.maps.LatLng(latitude, longitude),
                        zoom: 14
                    });
                    setMap(newMap);
                }
            } else {
                if (!map) {
                    alert("위치권한이 허용되어있지 않습니다.\n사용자의 실시간 위치를 불러올 수 없습니다.\n브라우저의 위치 권한을 허용하고 새로고침 해주세요.");
                    console.log("위치를 불러올 수 없어 지도 초기 위치를 '서울시청'으로 설정합니다. 위치권한을 허용하세요.");
                    //서울시청좌표
                    const latitude = 37.5642135;
                    const longitude = 127.0016985;
                    const newMap = new window.naver.maps.Map('map', {
                        center: new window.naver.maps.LatLng(latitude, longitude),
                        zoom: 14
                    });
                    setMap(newMap);
                }
            }
        }
    },[mapMaker]);





    // 지도 초기화 및 마커 설정
    useEffect(() => {

        console.log(clickedMotherId+"이게안나오아아앙아");
        if (userCoordinates.length !== 0 && clickedMotherId && data.length !==0) {


            console.log(userCoordinates[0]+"가져왔자나 ㅡㅡㅡ...")
            //가져온 사용자 모든정보 중 헬퍼자신과 mother가 가지고있는 helper들의 정보 배열
            const filteredUserCoordinates = userCoordinates.filter(coords => {
                console.log("안들어가는게 있니?"+loggedInUser + clickedMotherId + coords.user +"없네");
                if (coords.user === clickedMotherId ) return true;
                if (data.some(item => item.helper_id === coords.user)) return true;
                return false;
            });
            console.log(filteredUserCoordinates[0]+"걸른거에서 나오는 정보")
            // 기존 마커 삭제
            Object.values(markerRefs.current).forEach(marker => {
                marker.setMap(null);
            });


            const userCoordsRef2 = firebase.database().ref(`userLocations/${clickedMotherId}/nicknrel`);


            // 새로운 마커 생성 및 지도에 추가 (헬퍼자신과 mother가 가지고있는 helper들의 정보 배열)
            filteredUserCoordinates.forEach((coords) => {
                if(coords.user == clickedMotherId && myCoordinates.nicknrel[loggedInUser].locationallowmth == 1 || coords.user !== clickedMotherId) {


                    console.log(clickedMotherId + "클릭드마더아이디 내놔");
                    if (coords.latitude && coords.longitude && clickedMotherId) {
                        console.log("이거안들어오냐 고스탑");
                        const marker = new window.naver.maps.Marker({
                            position: new window.naver.maps.LatLng(coords.latitude, coords.longitude),
                            map: map,
                            title: coords.user,
                            icon: {
                                content: `
                                <div id=${coords.user}>
                                ${coords.user !== clickedMotherId ? `
                                    <div style="margin-bottom: 4px; padding: 4px; width: 68px; height: 24px; font-weight: bold; 
                                      background: ${myCoordinates.nicknrel[coords.user].gostop == 1 ? "rgba(40,180,256,0.4);" : myCoordinates.nicknrel[coords.user].gostop == 2 ? "rgba(256,149,149,0.4); " : "rgba(200,200,200,0.4);"} 
                                    border-radius: 12px; position: relative; z-index: 262; right: 10px; top: -35px;">
                                        
                                                    ${myCoordinates.nicknrel[coords.user].gostop == 1 ? "가는중" : myCoordinates.nicknrel[coords.user].gostop == 2 ? "못가요" : ""}
                                    </div>
                                ` : ''}
                                <div style="position:relative; z-index: 261; right: 10px; top: -35px;">
                                <svg width="33" height="42" viewBox="0 0 33 42" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M33 16.5C33 25.6127 18.1875 42 16.5 42C14.8125 42 0 25.6127 0 16.5C0 7.3873 7.3873 0 16.5 0C25.6127 0 33 7.3873 33 16.5Z" fill="#333333"/>
                                    <circle cx="16.5" cy="16.5" r="9.5" fill="${coords.color}" stroke="#ffffff" stroke-width="2"/>
                                 </svg>
                                 </div>
                                </div>
                                `,
                                size: new window.naver.maps.Size(33, 42),
                                anchor: new window.naver.maps.Point(16.5, 42),
                            },
                        });
                        // 클릭 이벤트 추가
                        markerRefs.current[coords.user] = marker;
                        window.naver.maps.Event.addListener(marker, 'click', function () {
                            setClickshowinfo(true);
                            setClickedElementId(coords.user === loggedInUser ? "나" : coords.user);
                            setClickedElementColor(coords.color);
                            setClickedElementName(coords.name);
                            setClickedElementTel(coords.tel);
                            setUserLocation({latitude: coords.latitude, longitude: coords.longitude});

                            if (myCoordinates.nicknrel[coords.user] !== 0) {
                                setClickedElementRelation(myCoordinates.nicknrel[coords.user].relation);
                            }
                            if (myCoordinates.nicknrel[coords.user] == clickedMotherId) {
                                setClickedElementRelation('');
                            }
                            if (coords.user == clickedElementId) {
                                setClickedElementLocationAllowMth(myCoordinates.nicknrel[coords.user].locationallowmth);
                            }

                        });
                    }
                }
            });

        }
    }, [loggedInUser, userCoordinates, selectedGoStop, selectedMother_Id, data, myCoordinates]);



    // chatbtn 클릭 시 ChatRoom 표시 여부 토글
    const toggleChatRoom = () => {
        setShowChat(prevState => !prevState);
        setClickshowinfo(false);
    };

    // 사용자 위치로 이동하는 함수
    const moveToUserLocation = () => {
        if (map && userLocation.latitude && userLocation.longitude) {
            map.setCenter(new window.naver.maps.LatLng(userLocation.latitude, userLocation.longitude));
        }
    };
    const moveToMyLocation = () => {
        if (map && myLocation.latitude && myLocation.longitude) {
            map.setCenter(new window.naver.maps.LatLng(myLocation.latitude, myLocation.longitude));
        }
        setClickshowinfo(false);
    };

    const showinfo = (event, userId, userColor, latitude, longitude, name, tel, relation, locationallowmth) => {
        // userId 변수를 사용하여 클릭된 요소를 식별할 수 있습니다.
        setClickedElementId(userId === loggedInUser ? "나" : userId);
        setClickshowinfo(true);
        setClickedElementColor(userColor);
        setUserLocation({ latitude, longitude });
        if(relation !== ""){
            setClickedElementRelation(relation);
        }
        if(locationallowmth !== "") {
            setClickedElementLocationAllowMth(locationallowmth);
        }
        setClickedElementName(name);
        setClickedElementTel(tel)

    }
    const closeinfo = () => {
        // userId 변수를 사용하여 클릭된 요소를 식별할 수 있습니다.
        setClickshowinfo(false);

    }


    // 선택한 mother의 id를 설정하는 핸들러
    const handleMotherSelect = (event) => {
        const selectedMotherId = event.target.value;
        sessionStorage.setItem("mother_id",selectedMotherId);
        console.log("바뀌었습니다." + selectedMotherId)
        setSelectedMother_Id(selectedMotherId);

    };

    const gostopSelect = (event) => {
        console.log("꾸우꾸꼐꼐꼒꼐꼐" + myCoordinates.latitude)
        if(typeof myCoordinates.latitude !== 'undefined'){
            if (myLocation.latitude !== null) {
                const GoStop = event.target.value;
                sessionStorage.setItem("gostop", GoStop);
                console.log("바뀌었습니다." + GoStop)
                setSelectedGoStop(GoStop);

                // Firebase 경로 설정
                const locationRef2 = firebase.database().ref(`userLocations/${clickedMotherId}/nicknrel/${loggedInUser}/gostop`);

                // Firebase에 값 설정
                locationRef2.set(GoStop)
                    .then(() => {
                        console.log("Firebase에 값이 성공적으로 저장되었습니다.");
                    })
                    .catch((error) => {
                        console.error("Firebase에 값 저장 중 오류가 발생했습니다:", error);
                    });

                const selectElement = event.target;
                const selectedIndex = selectElement.selectedIndex;
                const selectedOption = selectElement.options[selectedIndex];

                selectElement.style.backgroundColor = selectedOption.style.backgroundColor;
                selectElement.style.color = selectedOption.style.color;
            } else {
                alert("위치권한을 허용하고 상태를 변경해주세요");
            }
        }else{
            alert("선택한 mother의 firebase 데이터가 없습니다. 마더가 먼저로그인하고 사용해주세요");
        }
    };

    useEffect(() => {
        if(loggedInUser && clickedMotherId) {
            const gostopRef = firebase.database().ref(`userLocations/${clickedMotherId}/nicknrel/${loggedInUser}/gostop`);
            gostopRef.once('value', (snapshot) => {
                let gostopValue = snapshot.val();
                console.log(gostopValue +"몇이죠?");
                setSelectedGoStop(gostopValue);

            });
        }
    }, [loggedInUser, clickedMotherId]);


    return (
        <div style={{
            width: '480px',
            height: '770px',
            position: 'absolute',
            top: '160px'
        }}>


            <div style={{
                position: "absolute",
                top: "12px",
                right: "12px",
                zIndex: 260,
                width: "162px",
                height: "42px",

            }}>
                {/* MotherList 컴포넌트에서 받아온 mothers 배열을 사용하여 select 옵션을 생성 */}
                <select onChange={handleMotherSelect}

                        style={{width: "160px", height: "40px", fontWeight: "bold", fontSize: "20px"}}>
                    {/* 반복문 */}
                    {data2.map((mother) => (
                        <option style={{fontSize: "18px"}} key={mother.mother_id}
                                value={mother.mother_id} selected={mother.mother_id === clickedMotherId}>{mother.mother_name}</option> //오류나면 clickedMotherId sessionStorage.getItem("mother_id"); 이것으로 교체 이거됨.
                    ))}
                    {/* /반복문 */}
                </select>
            </div>

            <div style={{
                position: "absolute",
                top: "60px",
                right: "12px",
                zIndex: 260,
                width: "162px",
                height: "42px",


            }}>
                {/* MotherList 컴포넌트에서 받아온 mothers 배열을 사용하여 select 옵션을 생성 */}
                <select onChange={gostopSelect} style={{
                    width: "160px",
                    height: "40px",
                    background: selectedGoStop == 1 ? "rgba(40,180,256,0.5)": selectedGoStop == 2 ? "rgba(256,149,149,0.5)" : "rgba(200,200,200,0.4)" ,
                    borderRadius: "12px",
                    fontWeight: "bold",
                    fontSize: "20px"
                }}>
                    <option selected={selectedGoStop == 0} value="0" style={{color: "black", fontSize: "18px", fontWeight: "bold", backgroundColor:"rgba(200,200,200,0.4)"}}>선택</option>
                    <option selected={selectedGoStop == 1}  value="1" style={{color: "black", fontSize: "18px", fontWeight: "bold", backgroundColor:"rgba(40,180,256,0.4)"}}>가는중</option>
                    <option selected={selectedGoStop == 2}  value="2" style={{color: "black", fontSize: "18px", fontWeight: "bold", backgroundColor:"rgba(256,149,149,0.4)"}}>못가요</option>
                </select>
            </div>


            <div id="map" style={{
                width: '480px',
                height: '770px',
                position: 'absolute',
                left: 0, top: 0
            }}>
                <div style={{
                    visibility: clickshowinfo ? 'visible' : 'hidden',
                    width: "440px",
                    height: "128px",
                    background: "rgba(0,0,0,0.6)",
                    borderRadius: "20px",
                    position: 'absolute',
                    left: "20px",
                    zIndex: 261,
                }}>
                    <div style={{
                        position: "absolute",
                        left: '12px',
                        top: '8px',
                        width: '28px',
                        height: '28px',
                        borderRadius: '50%',
                        background: clickedElementColor,
                        border: "2px solid white"
                    }}/>
                    <div style={{
                        position: "absolute",
                        right: '12px',
                        top: '8px',
                        width: '32px',
                        height: '32px',

                        color: 'white',
                        fontSize: '40px',
                        zIndex: 262
                    }} onClick={(event) => closeinfo()}><i style={{position: "absolute", top: '-10px', left: '-3px'}}
                                                           class="bi bi-x"></i></div>

                    <div style={{
                        position: "absolute",
                        left: '60px',
                        top: '8px',
                        fontSize: '20px',
                        color: 'white',
                        textAlign: 'left'
                    }}>
                        {clickedElementId == "나" ? "" : "아이디:"} <strong
                        style={{color: '#ff578b'}}>{clickedElementId}</strong>
                        <br/>

                        이름: <strong
                        style={{color: '#ff578b'}}>{clickedElementName}</strong>
                        (산모와관계:<strong style={{color: '#ff578b'}}>{clickedElementId !== clickedMotherId ? clickedElementRelation : "산모본인"}</strong>)<br/>
                        전화번호:<strong style={{color: '#ff578b'}}>{clickedElementTel}</strong>
                    </div>
                    <div style={{position: 'absolute', bottom: '8px', left: '8px', width: '40px'}}
                         onClick={moveToUserLocation}>
                        <svg width="33" height="33" viewBox="0 0 33 33" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="16.5012" cy="16.4997" r="10.05" stroke="white" stroke-width="3"/>
                            <rect x="14.8516" width="3.3" height="5.775" fill="white"/>
                            <rect x="14.8516" y="27.2251" width="3.3" height="5.775" fill="white"/>
                            <rect x="5.77539" y="14.8501" width="3.3" height="5.775"
                                  transform="rotate(90 5.77539 14.8501)"
                                  fill="white"/>
                            <rect x="33" y="14.8501" width="3.3" height="5.775" transform="rotate(90 33 14.8501)"
                                  fill="white"/>
                        </svg>
                        <div style={{color: 'white', fontSize: '10px'}}>위치보기</div>
                    </div>
                </div>


                <div style={{
                    position: "absolute",
                    width: "40px",
                    height: "40px",
                    borderRadius: "50%",
                    border: "4px solid #ff578b",
                    boxShadow: "0 0 2px 2px lightgrey",
                    left: "20px",
                    bottom: "150px",
                    zIndex: "254",
                    background: "#fff",
                    textAlign: "center",
                    cursor: "pointer"
                }} onClick={moveToMyLocation}>
                    <div style={{marginTop: '4px'}}>
                        <svg width="33" height="33" viewBox="0 0 33 33" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="16.5012" cy="16.4997" r="10.05" stroke="#FF578B" stroke-width="3"/>
                            <rect x="14.8516" width="3.3" height="5.775" fill="#FF578B"/>
                            <rect x="14.8516" y="27.2251" width="3.3" height="5.775" fill="#FF578B"/>
                            <rect x="5.77539" y="14.8501" width="3.3" height="5.775"
                                  transform="rotate(90 5.77539 14.8501)"
                                  fill="#FF578B"/>
                            <rect x="33" y="14.8501" width="3.3" height="5.775" transform="rotate(90 33 14.8501)"
                                  fill="#FF578B"/>
                        </svg>
                    </div>
                </div>
                <div style={{position: "absolute", zIndex: "263", visibility: showChat ? "visible" : "hidden"}}>
                    <ChatRoom roomId={clickedMotherId} loggedInUser={loggedInUser} toggleChatRoom={toggleChatRoom}/>
                </div>

                <div style={{
                    position: "absolute",
                    width: "56px",
                    height: "56px",
                    borderRadius: "50%",
                    border: "4px solid #ff578b",
                    boxShadow: "0 0 2px 2px lightgrey",
                    right: "20px",
                    bottom: "150px",
                    zIndex: "254",
                    background: "#fff"

                }}>
                    <div id={"chatbtn"} style={{marginTop: "11px"}} onClick={toggleChatRoom}>
                        <svg width="44" height="39" viewBox="0 0 44 39" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M44 16.1743C44 20.8183 41.3378 25.0053 37.0741 27.9551C35.6173 28.963 34.2222 38.9841 33.8148 38.9841C33.8148 39.3988 29.0144 31.5645 27.2963 31.8767C25.5999 32.185 23.8259 32.3485 22 32.3485C9.84974 32.3485 0 25.107 0 16.1743C0 7.24146 9.84974 0 22 0C34.1503 0 44 7.24146 44 16.1743Z"
                                fill="#FF578B"/>
                        </svg>
                        <div style={{
                            position: "absolute",
                            zIndex: "254",
                            fontSize: "16px",
                            fontWeight: "bold",
                            color: "white",
                            top: "14px",
                            left: "10px"
                        }}>Chat
                        </div>

                    </div>


                </div>


                <div style={{
                    position: "absolute",
                    width: "440px",
                    background: "rgba(256,256,256,0.8)",
                    zIndex: "253",
                    bottom: "8px",
                    left: "20px",
                    borderRadius: "20px",
                    boxShadow: "0 0 2px 2px lightgrey"
                }}>
                    <div style={{color: "#ff578b", fontSize: "16px", margin: "auto"}}> 위급상황 시 모든 헬퍼의 위치가 공개됩니다.</div>
                    <style>{` .container::-webkit-scrollbar{display: none;} `}</style>
                    <div className={"container"} style={{
                        width: "420px",
                        height: "110px",
                        margin: "auto",
                        textAlign: "left",
                        overflowY: "auto"
                    }}>
                        {userCoordinates.filter(coords => {
                            if (coords.user === clickedMotherId) return true;
                            if (data.some(item => item.helper_id === coords.user)) return true;

                            return false;
                        }).map((coords, index) => (
                            <div style={{width: "32%", height: "40px", display: "inline-block", padding: "2px"}}
                                 onClick={(event) =>
                                     showinfo(event, coords.user, coords.color, coords.latitude, coords.longitude, coords.name, coords.tel,
                                         `${myCoordinates.nicknrel[coords.user] ? myCoordinates.nicknrel[coords.user].relation : "" }`,
                                         `${coords.user == clickedMotherId ? myCoordinates.nicknrel[loggedInUser].locationallowmth : "" }`)}>
                                <div style={{
                                    width: "36px",
                                    height: "36px",
                                    borderRadius: "18px",
                                    background: coords.color,
                                    display: "inline-block"
                                }}></div>
                                <div style={{width: "96px", height: "40px", display: "inline-block"}}>
                                    <div style={{
                                        width: "96px",
                                        height: "24px",
                                        fontSize: "20px"
                                    }}>{coords.user === loggedInUser ? "나" : coords.name}</div>
                                    <div style={{width: "96px", height: "16px", fontSize: "12px"}}>

                                        {coords.user == clickedMotherId && userCoordinates.filter(coordss=> {
                                            if (coordss.user === clickedMotherId) return true;
                                            return false;
                                        }).map((coordss, index) => {
                                            return <div key={index}>위치공유:{coordss.nicknrel[loggedInUser].locationallowmth == 1 ? "on" : coordss.nicknrel[loggedInUser].locationallowmth == 0 ? "off" : 'null' }</div>; // JSX를 반환하도록 수정
                                        })}


                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

            </div>

        </div>
    );
}

export default MothersLocation;