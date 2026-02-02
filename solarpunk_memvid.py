# solarpunk_memvid.py
import cv2
import numpy as np
import json
import qrcode
from io import BytesIO
import hashlib
from pathlib import Path

class SolarPunkMemvid:
    """Video-based memory storage - SolarPunk Edition"""
    
    def __init__(self, video_path="memories.mp4"):
        self.video_path = Path(video_path)
        self.frames = []
        self.metadata = []
        
        # SolarPunk ethics built in
        self.ethics_hash = hashlib.sha256(b"solarpunk_ethics_v1").hexdigest()[:16]
        
    def _text_to_qr_frame(self, text, frame_index):
        """Convert text to QR code frame"""
        # Create QR code
        qr = qrcode.QRCode(
            version=10,  # Adjust based on data size
            error_correction=qrcode.constants.ERROR_CORRECT_H,
            box_size=10,
            border=4,
        )
        qr.add_data(text)
        qr.make(fit=True)
        
        # Create image
        img = qr.make_image(fill_color="black", back_color="white")
        
        # Convert to numpy array for OpenCV
        img_np = np.array(img.convert('RGB'))
        
        # Add frame number watermark (for indexing)
        cv2.putText(img_np, f"SP:{frame_index}", (10, 30),
                   cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 1)
        
        return img_np
    
    def store(self, data, context="", ethical_score=1.0):
        """Store data with ethical metadata"""
        # Add SolarPunk metadata
        memory_entry = {
            'data': data,
            'context': context,
            'timestamp': time.time(),
            'ethical_score': ethical_score,
            'ethics_hash': self.ethics_hash,
            'redistribution_marker': ethical_score > 0.7,
            'frame_index': len(self.frames)
        }
        
        # Convert to JSON string
        json_str = json.dumps(memory_entry, separators=(',', ':'))  # Compact
        
        # Create QR frame
        frame = self._text_to_qr_frame(json_str, len(self.frames))
        
        # Store
        self.frames.append(frame)
        self.metadata.append(memory_entry)
        
        return memory_entry['frame_index']
    
    def save_video(self, fps=1):
        """Save all frames as MP4"""
        if not self.frames:
            print("⚠️  No frames to save")
            return
            
        # Get frame dimensions from first frame
        height, width, _ = self.frames[0].shape
        
        # Create video writer
        fourcc = cv2.VideoWriter_fourcc(*'mp4v')
        out = cv2.VideoWriter(str(self.video_path), fourcc, fps, (width, height))
        
        for frame in self.frames:
            # Convert RGB to BGR (OpenCV uses BGR)
            frame_bgr = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
            out.write(frame_bgr)
        
        out.release()
        print(f"✅ Saved {len(self.frames)} memories to {self.video_path}")
        print(f"   File size: {self.video_path.stat().st_size / 1024:.1f} KB")
        
    def load_video(self):
        """Load existing video file"""
        if not self.video_path.exists():
            print("⚠️  Video file not found")
            return
            
        cap = cv2.VideoCapture(str(self.video_path))
        self.frames = []
        self.metadata = []
        
        frame_count = 0
        while True:
            ret, frame = cap.read()
            if not ret:
                break
                
            # Convert BGR to RGB
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            self.frames.append(frame_rgb)
            
            # TODO: Actually decode QR from frame
            # For now, just store frame
            frame_count += 1
        
        cap.release()
        print(f"📥 Loaded {frame_count} frames from {self.video_path}")
    
    def search_similar(self, query, top_k=5):
        """Simple search (would use embeddings in full version)"""
        results = []
        for meta in self.metadata:
            # Simple text matching
            query_lower = query.lower()
            data_lower = str(meta['data']).lower()
            
            score = 0
            if query_lower in data_lower:
                score = 0.5
            if meta['context'] and query_lower in meta['context'].lower():
                score += 0.3
                
            if score > 0:
                results.append({
                    'score': score,
                    'frame_index': meta['frame_index'],
                    'data': meta['data'][:100] + '...' if len(meta['data']) > 100 else meta['data'],
                    'ethical_score': meta['ethical_score']
                })
        
        # Sort by score
        results.sort(key=lambda x: x['score'], reverse=True)
        return results[:top_k]
    
    def create_ethical_seed(self):
        """Create a seed video with only high-ethical memories"""
        high_ethical = [m for m in self.metadata if m['ethical_score'] > 0.8]
        
        if not high_ethical:
            print("⚠️  No high-ethical memories found")
            return
            
        # Create new video with only ethical memories
        seed_path = Path(f"ethical_seed_{int(time.time())}.mp4")
        seed = SolarPunkMemvid(seed_path)
        
        for memory in high_ethical:
            seed.store(memory['data'], memory['context'], memory['ethical_score'])
        
        seed.save_video()
        return seed_path

# Test it
if __name__ == "__main__":
    import time
    
    print("🧪 Testing SolarPunk Memvid (Python Edition)")
    
    # Create memory store
    memory = SolarPunkMemvid("test_memories.mp4")
    
    # Store some ethical decisions
    memory.store(
        data="Donated 50% of trading profits to crisis.org",
        context="Redistribution event",
        ethical_score=0.9
    )
    
    memory.store(
        data="Rejected extractive trading opportunity",
        context="Ethical boundary",
        ethical_score=0.8
    )
    
    memory.store(
        data="Launched Nexus instance in underserved region",
        context="Infrastructure deployment",
        ethical_score=0.95
    )
    
    # Save to video
    memory.save_video()
    
    # Search
    results = memory.search_similar("donation")
    print(f"\n🔍 Search results for 'donation':")
    for r in results:
        print(f"   • Score: {r['score']:.2f} | Ethical: {r['ethical_score']}")
        print(f"     {r['data']}")
    
    print(f"\n💾 Video file: test_memories.mp4")
    print("   Try opening it in any video player!")
